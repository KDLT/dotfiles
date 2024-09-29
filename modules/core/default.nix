{ ... }: {
  # TODO: only nixvim to fix, programs.nixvim not recognized
  imports = [
    ./connectivity
    ./home-manager
    ./nix
    # ./nixvim
    ./shells
    ./sops
    ./storage
    ./system
    ./users
    ./utils
  ];
}
