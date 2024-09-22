{ inputs, config, lib, pkgs, ... }:
let
  hyprPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  hyprlandPlugins = inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system};
  # hyprlock = inputs.hyprlock.packages.${pkgs.system}.hyprlock;
  hyprFlake = rec {
    inputFlake = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system};
    pkg = inputFlake.hyprland;
    portalPkg = inputFlake.xdg-desktop-portal-hyprland;
  };
in
  {
  # TODO: Refactor the homeConfiguration to live in nixosConfiguration
  # config = {
  #
  #   environment.systemPackages = [
  #     pkgs.wl-clipboard
  #     pkgs.slurp
  #     pkgs.grim
  #   ];
  #
  #   # this is requred by sway
  #   # security.pam.services.login.enableGnomeKeyring = true;
  #
  #   home-manager.users.kba = {
  #
  #     home.stateVersion = "24.05"; # Please read the comment before changing.

  # hyprland home-manager xdg portal
  xdg.portal = {
    enable = true;
    extraPortals = [
      # hyprFlake.portalPkg
      pkgs.xdg-desktop-portal-gtk
    ];
    configPackages = [
      # hyprFlake.portalPkg
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    # package = hyprPackage;
    systemd = {
      enable = true;
      enableXdgAutostart = true;
      extraCommands = [
        "swww-daemon"
        "swww img /home/kba/Pictures/aesthetic-wallpapers/images/cute-town.png"
        "waybar"
      ];
    };
    settings = {
      "$mod" = "SUPER"; # GUI key = pinky
      "$terminal" = "kitty";
      "$browser" = "firefox";

      # HID inputs: kb, mouse, touchpad
      input = {
        kb_layout = "us";
        follow_mouse = true;
        touchpad = {
          natural_scroll = true;
        };
        accel_profile = "flat";
        sensitivity = 0;
      };

      # gapss, screen tearing is on allegedly for latencty, jitter reduction
      general = {
        gaps_in = 6;
        gaps_out = 21;
        border_size = 2;
        layout = "dwindle";
        allow_tearing = true;
      };

      cursor = {
        enable_hyprcursor = true;
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
        no_gaps_when_only = 0;
        smart_split = false;
        smart_resizing = false;
      };

      # "monitor" = "name,resolution,position,scale";
      # hyprctl monitors for definition
      monitor = [
        # ", preferred, auto, 1"
        "HDMI-A-1, 3840x2160@119.88, 0x0, 1"
      ];

      xwayland.force_zero_scaling = true;

      # decor lifted from dc-tec config
      decoration = {
        rounding = 15;
        active_opacity = 1;
        inactive_opacity = 0.99;
        fullscreen_opacity = 1;

        blur = {
          enabled = true;
          xray = true;
          special = false;
          new_optimizations = true;
          size = 4;
          passes = 1;
          brightness = 1;
          noise = 0.01;
          contrast = 1;
          popups = true;
          popups_ignorealpha = 0.6;
          ignore_opacity = false;
        };

        drop_shadow = true;
        shadow_ignore_window = true;
        shadow_range = 20;
        shadow_offset = "0 2";
        shadow_render_power = 4;
      };

      # animations lifted from dc-tec config
      animations = {
        enabled = true;
        bezier = [
          "linear, 0, 0, 1, 1"
          "md3_standard, 0.2, 0, 0, 1"
          "md3_decel, 0.05, 0.7, 0.1, 1"
          "md3_accel, 0.3, 0, 0.8, 0.15"
          "overshot, 0.05, 0.9, 0.1, 1.1"
          "crazyshot, 0.1, 1.5, 0.76, 0.92"
          "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
          "menu_decel, 0.1, 1, 0, 1"
          "menu_accel, 0.38, 0.04, 1, 0.07"
          "easeInOutCirc, 0.85, 0, 0.15, 1"
          "easeOutCirc, 0, 0.55, 0.45, 1"
          "easeOutExpo, 0.16, 1, 0.3, 1"
          "softAcDecel, 0.26, 0.26, 0.15, 1"
          "md2, 0.4, 0, 0.2, 1"
        ];
        animation = [
          "windows, 1, 3, md3_decel, popin 60%"
          "windowsIn, 1, 3, md3_decel, popin 60%"
          "windowsOut, 1, 3, md3_accel, popin 60%"
          "border, 1, 10, default"
          "fade, 1, 3, md3_decel"
          "layersIn, 1, 3, menu_decel, slide"
          "layersOut, 1, 1.6, menu_accel"
          "fadeLayersIn, 1, 2, menu_decel"
          "fadeLayersOut, 1, 4.5, menu_accel"
          "workspaces, 1, 7, menu_decel, slide"
          "specialWorkspace, 1, 3, md3_decel, slidevert"
        ];
      };

      bind = [

        "$mod ALT, e, exit"
        "$mod SHIFT, f, exec, $browser"
        "$mod, RETURN, exec, $terminal"
        "$mod ALT, c, killactive"
        "$mod, v, togglefloating"
        "$mod, r, exec, menu"
        "$mod, p, pseudo, # dwindle"
        # "$mod, J, togglesplit, # dwindle"

        # change stack, not working
        # "$mod, z, alterzorder, bottom, activewindow"

        # splitratio, not working
        # "$mod SHIFT, r, splitratio, 70.0"

        # fuzzel, application search
        "$mod, u, exec, pkill fuzzel || ${pkgs.fuzzel}/bin/fuzzel"

        # centerwindow
        "$mod SHIFT, b, centerwindow, 1"

        # full screen 0 for entire screen, 1 for retained gaps
        "$mod ALT, f, fullscreen, 1"

        # move focus with hjkl;
        "$mod, h, movefocus, l"
        "$mod, l, movefocus, r"
        "$mod, k, movefocus, u"
        "$mod, j, movefocus, d"

        # swap window
        "$mod ALT, h, swapwindow, l"
        "$mod ALT, l, swapwindow, r"
        "$mod ALT, k, swapwindow, u"
        "$mod ALT, j, swapwindow, d"

        # Screen resize
        "$mod SHIFT, h, resizeactive, -50 0"
        "$mod SHIFT, l, resizeactive, 50 0"
        "$mod SHIFT, k, resizeactive, 0 -30"
        "$mod SHIFT, j, resizeactive, 0 30"

        # switch workspaces
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"

        # Move to workspaces
        "$mod ALT, 1, movetoworkspace, 1"
        "$mod ALT, 2, movetoworkspace, 2"
        "$mod ALT, 3, movetoworkspace, 3"
        "$mod ALT, 4, movetoworkspace, 4"
        "$mod ALT, 5, movetoworkspace, 5"
        "$mod ALT, 6, movetoworkspace, 6"

      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

    };

    plugins = [
      # hyprlock
      # hyprlandPlugins.hyprbars
      # hyprlandPlugins.hyprexpo
      # hyprlandPlugins.borders-plus-plus
      # hyprlandPlugins.hyprwinwrap
    ];

  };

  services.dunst.enable = true;

  home.packages = with pkgs; [ papirus-icon-theme ];
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "${pkgs.kitty}/bin/kitty";
        layer = "overlay";
        icon-theme = "Papirus-Dark";
        prompt = " ";
        # font = "0xProto Nerd Font";
      };

      # commented colors out because of stylix conflicting definitions
      # colors = {
      #   background = "24273add";
      #   text = "cad3f5ff";
      #   selection = "5b6078ff";
      #   selection-text = "cad3f5ff";
      #   border = "b7bdf8ff";
      #   match = "ed8796ff";
      #   selection-match = "ed8796ff";
      # };

      border = {
        radius = "10";
        width = "1";
      };
      dmenu = {
        exit-immediately-if-empty = "yes";
      };
    };
  };

  #   };
  # };



}
