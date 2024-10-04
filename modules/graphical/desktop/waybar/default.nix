{ config, lib, ...}:
{
  options = {
    kdlt.graphical.waybar.enable = lib.mkEnableOption "waybar on";
  };

  config = lib.mkIf config.kdlt.graphical.waybar.enable {
    home-manager.users.${config.kdlt.username} = { pkgs, ... }: {

      programs.waybar = {
        enable = true;
        systemd.enable = true;
        settings = {
          mainBar = {
            layer = "top";
            position = "top";
            height = 40;
            output = [ "HDMI-A-1" ];
            modules-left = [ "hyprland/workspaces" /* "hyprland/mode"  */"wlr/taskbar" ];
            modules-center = [ "hyprland/window" /* "custom/hello-from-waybar"  */];
            modules-right = [ "mpd" "custom/mymodule#with-css-id" "temperature" ];
            "hyprland/workspaces" = {
              disable-scroll = true;
              all-outputs = true;
            };
            "custom/hello-from-waybar" = {
              format = "hello {}";
              max-length = 40;
              interval = "once";
              exec = pkgs.writeShellScript "hello-from-waybar" ''
                echo "from within waybar"
              '';
            };
          };
        };
        style = ''
          * {
            border: none;
            border-radius: 0;
            font-family: JetBrains Mono Nerd Font Mono;
          }
          window#waybar {
            /* background: #16191C; */
            background: none;
            color: #000;
          }
          #workspace button {
            padding: 0 5px;
          }
        '';
      };
    };
  };
}
