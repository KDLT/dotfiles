{ config, lib, ... }:
with lib;
{
  imports = [
    ./desktop
    ./xdg
    ./terminal
    ./stylix # TODO: still infinite recursion when stylix is enabled
    ./applications
    ./sound
  ];

  options = {
    kdlt.graphical = {
      enable = mkEnableOption "Graphical Environment";
      laptop = mkEnableOption "Laptop config";
    };
  };

  config = mkIf config.kdlt.graphical.enable {
    kdlt.graphical = {
      laptop = mkDefault false;
      sound = mkDefault true;
      terminal.enable = mkDefault true;
      xdg.enable = mkDefault true;
      applications = {
        firefox.enable = mkDefault true;
        obsidian.enable = mkDefault true;
      };
    };
  };
}
