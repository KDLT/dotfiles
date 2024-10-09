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

    anyrun.url = "github:anyrun-org/anyrun";
    anyrun.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim"; # for unstable channel
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:danth/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs-stable";
  };

  outputs = {
    self,
    nixpkgs,
    hyprland,
    anyrun,
    home-manager,
    nix-index-database,
    nixvim,
    stylix,
    ...
  } @ inputs: let
    # https://nixos.wiki/wiki/Nix_Language_Quirks
    # Since this is inside outputs the self argument allows
    # ALL `outputs` inheritable
    inherit (self) outputs; # this makes outputs inheritable below

    # allSystemNames = [ "x86_64-linux" "aarch64-darwin" ];
    # forAllSystems = func: (nixpkgs.lib.genAttrs allSystemNames func);
    forAllSystems = nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-darwin" ];

    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};

    user = {
      username = "kba";
      fullname = "Kenneth B. Aguirre";
      email = "aguirrekenneth@gmail.com";
    };

    hyprlandFlake = hyprland.packages.${pkgs.stdenv.hostPlatform.system};
    anyrunFlake = anyrun.packages.${pkgs.system};

    sharedModules = [
      # stylix.homeManagerModules.stylix # TODO: hm.nix gnome dconf issue
      # stylix.nixosModules.stylix # TODO: still suffering from infinite recursion

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
        specialArgs = {inherit inputs outputs user hyprlandFlake anyrunFlake;}; # i still don't know what outputs can be used for

        # system = system;
        # pkgs = pkgs; # only the home-manager module require this, it breaks things in nixosConf
        # presumably this is where `inherit (self) outputs` comes in handy
        # sharedmodules contain the ./modules directory and input flakes
      };
    };

    # TODO: test alejandra formatter on a rebuild next boot
    formatter = forAllSystems (
      system: nixpkgs.legacyPackages.${system}.alejandra
    );

    # formatter = {
    #   "x86_64-linux" = nixpkgs.legacyPackages.${"x86_64-linux" }.alejandra ;
    #   "aarch64-darwin" = nixpkgs.legacyPackages.${"aarch64-darwin"}.alejandra;
    # };

    # this is used for custom packages
    # packages = forAllSystems (system:
    #   let
    #     pkgs = nixpkgs.legacyPackages.${system};
    #   in
    #     import ./pkgs {inherit pkgs;});
  };
}
