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
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    stylix,
    nixvim,
    ...
    } @ inputs :
    let

      # https://nixos.wiki/wiki/Nix_Language_Quirks
      # Since this is inside outputs the self argument allows
      # ALL `outputs` inheritable
      inherit (self) outputs;
      # where to inherit from? self;
      # which to inherit? outputs;

      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      user = {
        username = "kba";
        fullname = "Kenneth Balboa Aguirre";
        email = "aguirrekenneth@gmail.com";
      };

      sharedModules = [
        # home-manager.nixosModules.home-manager because home-manager is default
        # CAUTION: WRONG! `home-manager` is required at the end because default does not exist
        home-manager.nixosModules.home-manager
        # home-manager.nixosModule

        # stylix.nixosModules.stylix # TODO: commented this out first to tackle the infinite recursion error later
        # nixvim.nixosModules.nixvim # TODO: commented this out first to tackle the infinite recursion error later

        ./modules # this points to default.nix that imports core, development, graphical
      ];

    in
      {
      # not sure if this is required since i'm already inheriting outputs in specialArgs
      packages = pkgs;

      nixosConfigurations = {
      # Super is my selected hostname
        Super = nixpkgs.lib.nixosSystem {
          system = system;
          specialArgs = {
            # presumably this is where `inherit (self) outputs` comes in handy
            inherit inputs outputs user;
            # all outputs ought to be passed to the special args as one

            # inherit inputs;
            # inherit outputs;
            # inherit pkgs;
            # inherit user;
          };
          # sharedmodules contain the ./modules directory and input flakes
          # modules = sharedModules ++ [ ./machines/Super/default.nix ];
          modules =  [
            ./machines/Super/default.nix
            home-manager.nixosModules.home-manager
            # stylix.nixosModules.stylix
            # nixvim.nixosModules.nixvim
            ./modules # i suspect this should be called last
          ];
        };
      };

      # homeConfigurations."kba" = home-manager.lib.homeManagerConfiguration {
      #   inherit pkgs;
      #
      #   # Specify your home configuration modules here, for example,
      #   # the path to your home.nix.
      #   modules = [
      #     ./home.nix
      #     nixvim.homeManagerModules.nixvim
      #     stylix.homeManagerModules.stylix
      #   ];
      #
      #   # Optionally use extraSpecialArgs
      #   # to pass through arguments to home.nix
      #   extraSpecialArgs = {inherit inputs;};
      # };
    };
}
