{
  description = "Nixos config flake";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    nur.url = "github:nix-community/NUR"; # nix user repository
    sops-nix.url = "github:Mic92/sops-nix"; # secrets management
    impermanence.url = "github:nix-community/impermanence"; # nuke / on every boot

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # home-manager.inputs.nixpkgs-stable.follows = "nixpkgs-stable";

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";

    hyprlock.url = "github:hyprwm/hyprlock";
    hyprlock.inputs.nixpkgs.follows = "hyprland";

    swww.url = "github:LGFae/swww";

    nixvim.url = "github:nix-community/nixvim"; # for unstable channel
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    # nixvim.inputs.nixpkgs-stable.follows = "nixpkgs-stable";
    # url = "github:nix-community/nixvim/nixos-${stable-ver}"; # for stable unstable channel
    # inputs.nixpkgs.follows = "nixpkgs-stable";

    stylix.url = "github:danth/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    hyprland,
    home-manager,
    stylix,
    nixvim,
    ...
    } @ inputs :
    let

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

      sharedModules = [
        home-manager.nixosModules.home-manager
        # stylix.homeManagerModules.stylix # TODO: commented this out first to tackle the infinite recursion error later
        # stylix.nixosModules.stylix # TODO: commented this out first to tackle the infinite recursion error later
        nixvim.nixosModules.nixvim # TODO: commented this out first to tackle the infinite recursion error later
        ./modules # this points to default.nix that imports core, development, graphical
      ];

    in
      {
      # not sure if this is required since i'm already inheriting outputs in specialArgs
      # packages = pkgs;

      # packages = forAllSystems (system:
      #   let
      #     pkgs = nixpkgs.legacyPackages.${system};
      #   in
      #     import ./pkgs {inherit pkgs;});

      nixosConfigurations = {
        Super = nixpkgs.lib.nixosSystem { # Super is my selected hostname
          # system = system;
          # pkgs = pkgs;
          specialArgs = {
            # presumably this is where `inherit (self) outputs` comes in handy
            inherit inputs outputs; # this does not work, does it?
            # all outputs ought to be passed to the special args as one

            # inherit inputs outputs;

            # inherit inputs;
            # inherit outputs;

            # inherit inputs;
            # inherit user;
          };
          # sharedmodules contain the ./modules directory and input flakes
          modules = sharedModules ++ [ ./machines/Super/default.nix ];
        };
      };
    };
}
