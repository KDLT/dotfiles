{ config, lib, ... }:
with lib;
{
  # TODO: only stylix errors out allegedly not existing
  imports = [
    ./desktop
    ./xdg
    ./terminal
    ./stylix
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
      # stylix.enable = mkDefault true;
      terminal.enable = mkDefault true;
      xdg.enable = mkDefault true;
      applications = {
        firefox.enable = mkDefault true;
        obsidian.enable = mkDefault true;
      };
    };
  };
}
