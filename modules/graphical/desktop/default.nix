{ config, lib, ...}:
with lib;
{
  imports = [
    ./anyrun
    ./fuzzel
    ./hyprland
    ./hyprlock
    ./hyprpaper
    ./key_management
    ./swaync
    ./swww
    ./waybar
    ./wlogout # TODO: set up script for wlogout etc.
  ];

  config = mkIf config.kdlt.graphical.enable {
    kdlt.graphical = {
      anyrun.enable = mkDefault true;
      fuzzel.enable = mkDefault true;
      hyprland.enable = mkDefault true;
      hyprlock.enable = mkDefault true;
      hyprpaper.enable = mkDefault true;
      key_management.enable = mkDefault true;
      swaync.enable = mkDefault true;
      swww.enable = mkDefault true;
      waybar.enable = mkDefault true;
      wlogout.enable = mkDefault true;
    };
  };
}
