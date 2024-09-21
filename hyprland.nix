{ inputs, pkgs, ... }:
let
  flakePkg = {
    hyprland = inputs.hyprland.packages.${pkgs.system}.hyprland;
    hyprlandPlugins = inputs.hyprland-plugins.packages.${pkgs.system}.hyprland;
    hyprlock = inputs.hyprlock.packages.${pkgs.system}.hyprlock;
  };
in
  {

  # this is requred by sway
  # security.pam.services.login.enableGnomeKeyring = true;

  programs.hyprland = {
    enable = false;
    package = flakePkg.hyprland;
    xwayland.enable = true; # enable XWayland
    systemd.enable = true; # enable hyprland-session.target on startup
  };

  wayland.windowManager.hyprland = {
    enable = false;
    settings = {
      # "$mod" = "SUPER";
      "$mainMod" = "SUPER";
      decoration = {
        shadow_offset = "0 5";
        "col.shadow" = "rgba(00000099)";
      };
      bindm = [
        # mouse movements
        "$mod, mouse:272, moveWindow"
        "$mod, mouse:273, resizeWindow"
        "$mod ALT, mouse:272, resizeWindow"
      ];
    };
    plugins = with flakePkg; [
      hyprlock
      hyprland-plugins.hyprbars
      hyprland-plugins.hyprexpo
      hyprland-plugins.borders-plus-plus
      hyprland-plugins.hyprwinwrap
    ];
  };

}
