{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    nur.url = "github:nix-community/NUR"; # nix user repository
    sops-nix.url = "github:Mic92/sops-nix"; # secrets management
    impermanence.url = "github:nix-community/impermanence"; # nuke / on every boot

    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";

    hyprlock.url = "github:hyprwm/hyprlock";
    hyprlock.inputs.nixpkgs.follows = "hyprland";

    swww.url = "github:LGFae/swww";

    nixvim.url = "github:nix-community/nixvim"; # for unstable channel
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    alejandra.url = "github:kamadorueda/alejandra/3.0.0";
    alejandra.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:danth/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs-stable";
  };

  outputs = {
    self,
    nixpkgs,
    hyprland,
    home-manager,
    nix-index-database,
    nixvim,
    alejandra,
    stylix,
    ...
  } @ inputs: let
    # https://nixos.wiki/wiki/Nix_Language_Quirks
    # Since this is inside outputs the self argument allows
    # ALL `outputs` inheritable
    inherit (self) outputs; # this makes outputs inheritable below

    # forAllSystems = nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-darwin" ];
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};

    user = {
      username = "kba";
      fullname = "Kenneth B. Aguirre";
      email = "aguirrekenneth@gmail.com";
    };

    hyprlandFlake = hyprland.packages.${pkgs.stdenv.hostPlatform.system};

    nixFormat = {
      environment.systemPackages = [alejandra.defaultPackage.${system}];
    };

    sharedModules = [
      # stylix.homeManagerModules.stylix # TODO: hm.nix gnome dconf issue
      # stylix.nixosModules.stylix # TODO: still suffering from infinite recursion
      nixFormat

      home-manager.nixosModules.home-manager
      nix-index-database.nixosModules.nix-index
      nixvim.nixosModules.nixvim
      ./modules # this points to default.nix that imports core, development, graphical
    ];
  in {
    nixosConfigurations = {
      Super = nixpkgs.lib.nixosSystem {
        # Super is my selected hostname
        modules = sharedModules ++ [./machines/Super/default.nix];
        specialArgs = {inherit inputs outputs user hyprlandFlake;}; # i still don't know what outputs can be used for

        # system = system;
        # pkgs = pkgs; # only the home-manager module require this, it breaks things in nixosConf
        # presumably this is where `inherit (self) outputs` comes in handy
        # sharedmodules contain the ./modules directory and input flakes
      };
    };

    # this is used for custom packages
    # packages = forAllSystems (system:
    #   let
    #     pkgs = nixpkgs.legacyPackages.${system};
    #   in
    #     import ./pkgs {inherit pkgs;});
  };
}
