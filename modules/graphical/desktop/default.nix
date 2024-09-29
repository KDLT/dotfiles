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
    ./wlogout
  ];

  # these are now declared in their respective files
  # options = {
  #   kdlt.graphical = {
  #     anyrun.enable = mkEnableOption "Enable Anyrun";
  #     fuzzel.enable = mkEnableOption "Enable Fuzzel";
  #     hyprland.enable = mkEnableOption "Enable Hyprland";
  #     hyprlock.enable = mkEnableOption "Enable Hyprlock";
  #     hyprpaper.enable = mkEnableOption "Enable Hyprpaper";
  #     key_management.enable = mkEnableOption "Enable Key_management";
  #     swaync.enable = mkEnableOption "Enable Swaync";
  #     swww.enable = mkEnableOption "Enable Swww";
  #     waybar.enable = mkEnableOption "Enable Waybar";
  #     wlogout.enable = mkEnableOption "Enable Wlogout";
  #   };
  # };

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
