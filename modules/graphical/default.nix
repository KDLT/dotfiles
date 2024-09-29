{ config, lib, ... }:
with lib;
{
  imports = [
    ./desktop
    ./xdg
    ./terminal
    ./theme
    ./applications
    ./sound
  ];

  options = {
    kdlt.graphical = {
      enable = mkEnableOption "graphical env?";
      laptop = mkEnableOption "laptop config?";
    };
  };

  config = mkIf config.kdlt.graphical.enable {
    kdlt.graphical = {
      hyprland.enable = mkDefault true;
      hyprlock.enable = mkDefault true;
      swww.enable = mkDefault true;
      waybar.enable = mkDefault true;
      terminal.enable = mkDefault true;
      xdg.enable = mkDefault true;
      fuzzel.enable = mkDefault true;
      sound.enable = mkDefault true;
      stylix.enable = mkDefault true;
      applications.enable = {
        firefox.enable = true;
        obsidian.enable = true;
      };
    };
  };

}
