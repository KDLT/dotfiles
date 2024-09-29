{
  description = "Nixos config flake";

  inputs = rec {
    stable-ver = "24.05";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-${stable-ver}";

    nur.url = "github:nix-community/NUR"; # nix user repository
    sops-nix.url = "github:Mic92/sops-nix"; # secrets management
    impermanence.url = "github:nix-community/impermanence"; # nuke / on every boot

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.inputs.nixpkgs-stable.follows = "nixpkgs-stable";

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";

    hyprlock.url = "github:hyprwm/hyprlock";
    hyprlock.inputs.nixpkgs.follows = "hyprland";

    swww.url = "github:LGFae/swww";

    nixvim.url = "github:nix-community/nixvim"; # for unstable channel
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.inputs.nixpkgs-stable.follows = "nixpkgs-stable";
    # url = "github:nix-community/nixvim/nixos-${stable-ver}"; # for stable unstable channel
    # inputs.nixpkgs.follows = "nixpkgs-stable";

    stylix.url = "github:danth/stylix";
  };

  outputs = inputs@{
    self,
    nixpkgs,
    home-manager,
    stylix,
    nixvim,
    ... }:
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
        home-manager.nixosModules
        # these were previously homeManagerModules
        stylix.nixosModules.stylix
        nixvim.nixosModules.nixvim
        # this points to default.nix that imports core, development, graphical
        ./modules
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
            # inherit inputs outputs;
            # inherit inputs;
            # inherit outputs;
            # inherit pkgs;
            # inherit user;
          };
          # sharedmodules contain the ./modules directory and input flakes
          modules = sharedModules ++ [ ./machines/Super/default.nix ];
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
