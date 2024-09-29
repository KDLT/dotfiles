{ config, lib, pkgs, user, ... }:
let
  username = user.username;
in
{
  options = {
    kdlt.graphical.xdg.enable = lib.mkEnableOption "xdg folders";
  };

  config = lib.mkIf config.kdlt.graphical.xdg.enable {
    home-manager.users.${username} = {}: {

      xdg = {
        enable = true;
        userDirs.enable = true;
        userDirs.createDirectories = true;
      };

    };
  };
}
