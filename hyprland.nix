{ inputs, pkgs, ... }:
let
  hyprlandPlugins = inputs.hyprland-plugins.packages.${pkgs.system}.hyprland;
  hyprlock = inputs.hyprlock.packages.${pkgs.system}.hyprlock;
in
  {

  # this is requred by sway
  # security.pam.services.login.enableGnomeKeyring = true;

  wayland.windowManager.hyprland = {
    enable = true;
    # settings = {
    #   "$mod" = "SUPER";
    #   decoration = {
    #     shadow_offset = "0 5";
    #     # "col.shadow" = "rgba(00000099)";
    #   };
    #   bindm = [
    #     # mouse movements
    #     "$mod, mouse:272, moveWindow"
    #     "$mod, mouse:273, resizeWindow"
    #     "$mod ALT, mouse:272, resizeWindow"
    #   ];
    # };
    # plugins = with flakePkg; [
    #   hyprlock
    #   hyprlandPlugins.hyprbars
    #   hyprlandPlugins.hyprexpo
    #   hyprlandPlugins.borders-plus-plus
    #   hyprlandPlugins.hyprwinwrap
    # ];
  };

}
