{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # kickstart-nix-nvim = {
    #   # url = "github:nix-community/kickstart-nix.nvim";
    #   # url = "github:KDLT/kickstart-nix.nvim";
    #   url = "/home/kba/code/github/kickstart-nix.nvim";
    # };
    nixvim = {
      # for unstable channel
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
      # if using stable channel
      # url = "github:nix-community/nixvim/nixos-24.05";
      # inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    stylix.url = "github:danth/stylix";
  };

  outputs = { nixpkgs, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    lib = nixpkgs.lib;

    home-manager = inputs.home-manager;
    stylix = inputs.stylix;
    nixvim = inputs.nixvim;
  in
  {

    nixosConfigurations.K-Nixtop = lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./configuration.nix
        home-manager.nixosModules.default
        # stylix.nixosModules.stylix # cannot coexist with the homeManagerModules
      ];
    };

    homeConfigurations."kba" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      # Specify your home configuration modules here, for example,
      # the path to your home.nix.
      modules = [
        ./home.nix
        nixvim.homeManagerModules.nixvim
        stylix.homeManagerModules.stylix
      ];

      # Optionally use extraSpecialArgs
      # to pass through arguments to home.nix
      extraSpecialArgs = {inherit inputs;};
    };
  };
}
