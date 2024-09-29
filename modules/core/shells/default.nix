{ pkgs, ... }:
{

  imports = [
    ./zsh
    ./oh-my-posh
    ./starship.nix
  ];

  environment.shells = with pkgs; [
    zsh bash fish
  ];

  users = {
    defaultUserShell = pkgs.zsh;
  };

}
