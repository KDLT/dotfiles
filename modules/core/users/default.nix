{ config, pkgs, user, ... }:
let
  username = user.username;
  fullname = user.fullname;
in
{
  config = {
    users = {
      # true is default, TODO: set to false after
      # implementing secrets management, see commented lines below
      mutableUsers = true;
      ${username} = {
        isNormalUser = true;
        description = fullname;
        extraGroups = [ "wheel" "networkmanager" ];
        shell = pkgs.zsh;
        # hashedPasswordFile = config.sops.secrets."users/${username}".path;
      };
      # root.hashedPasswordFile = config.sops.secrets."users/root".path;
    };
  };
}
