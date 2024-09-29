{ config, lib, pkgs, inputs, user, ...}:

let
  username = user.username;

  hyprlandPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  hyprlandPortalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
in

{
  options = {
    kdlt = {
      graphical.hyprland.enable = lib.mkEnableOption "enable hyprlandwm";
      core.gpu.nvidia = lib.mkEnableOption "is gpu nvidia?";
    };
  };

  # hyprland configs to set when enable = true in host's configuration.nix
  config = lib.mkIf config.kdlt.graphical.hyprland.enable {

    nix.settings = {
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };

    # nvidia hyprland reference: https://wiki.hyprland.org/Nvidia/#installation

    # for wayland compositors to load properly these nvidia driver modules need to be loaded in initramfs
    boot = lib.mkIf config.kdlt.core.gpu.nvidia {
      # normally in /etc/modprobe.d/nvidia.conf located in /etc/modprobe.d/nixos.conf
      extraModprobeConfig = "options nvidia_drm modeset=1 fbdev=1\n";
      # normally in /etc/mkinitcpio.conf located in /etc/modules-load.d/nixos.conf
      initrd.kernelModules = [
        "nvidia"
        "nvidia_modeset"
        "nvidia_uvm"
        "nvidia_drm"
      ];
    };

    # hyprland requirements for nvidia gpus
    nixpkgs.config.allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [
        "nvidia-utils"
        "lib32-nvidia-utils"
      ];

    environment.systemPackages = with pkgs; [
      # the actual hyprland package from the input flake
      hyprlandPackage
      # compatibility between EGL API and wayland protocol
      egl-wayland
      # "desktop contents manipulation"
      wl-clipboard slurp grim
      # qt compatibility, note: dc-tec has these in home.packages
      qt5.qtwayland qt6.qtwayland
      # this creates the popup when an app wants elevated privilege
      polkit-kde-agent
    ];

    # TODO: test if this xserver setting is required by hyprland
    services.xserver.enable = true;

    # # hyprland, hyprlock, & waybar
    programs = {
      xwayland.enable = true;
      hyprland = {
        enable = true;
        package = hyprlandPackage;
        portalPackage = hyprlandPortalPackage;
        xwayland.enable = true;
      };
      waybar.enable = true;
      hyprlock.enable = true;
    };

    # hyprland home-manager xdg portal
    xdg.portal = {
      enable = true;
      extraPortals = [ hyprlandPortalPackage ]; # pkgs.xdg-desktop-portal-gtk
      configPackages = [ hyprlandPortalPackage ]; # pkgs.xdg-desktop-portal-gtk
    };

    home-manager.users."${username}" = { ... }: {

      home.packages = with pkgs; [
        # for qtwayland support packages
        qt5.qtwayland qt6.qtwayland
      ];

      services.cliphist.enable = true;

      wayland.windowManager.hyprland = {
        enable = true;
        # package = hyprFlake.pkg;
        # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        # package = inputs.hyprland.packages.${pkgs.system}.hyprland;
        xwayland.enable = true;
        systemd = {
          enable = true;
          enableXdgAutostart = true;
          # extraCommands = [ ];
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
            no_hardware_cursors = true; # nvidia hyprland requirement
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

          env = [
            # nvidia hyprland environment variables
            "LIBVA_DRIVER_NAME,nvidia"
            "XDG_SESSION_TYPE,wayland"
            "GBM_BACKEND,nvidia-drm"
            "__GLX_VENDOR_LIBRARY_NAME,nvidia"
            "NIXOS_OZONE_WL,1"

            ## these are from dc-tec, dunno what they do
            # "_JAVA_AWT_WM_NONREPARENTING,1"
            # "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
            # "QT_QPA_PLATFORM,wayland"
            # "SDL_VIDEODRIVER,wayland"
            # "GDK_BACKEND,wayland"
            # "XDG_SESSION_DESKTOP,Hyprland"
            # "XDG_CURRENT_DESKTOP,Hyprland"
          ];

          exec-once = [
            # "${pkgs.waybar}" # this supposedly proper way doesn't seem to work
            # "${pkgs.waybar}/bin/waybar" # nevermind, i'm just dumb
            # "waybar" # while this works

            # calling swww here works but doesn't on xdgautostart
            "${pkgs.swww}/bin/swww-daemon"
            "${pkgs.swww}/bin/swww img /home/kba/Pictures/aesthetic-wallpapers/images/minim-helmet.png"

            "${pkgs.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1"

            # open a kitty and firefox
            "${pkgs.kitty}/bin/kitty"
            "${pkgs.firefox}/bin/firefox"

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

    };

  };
}
