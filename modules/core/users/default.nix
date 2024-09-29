{ config, pkgs, user, ... }:
{
  config = {
    users = {
      # true is default, TODO: set to false after
      # implementing secrets management, see commented lines below
      mutableUsers = true;
      users = {
        ${user.username} = {
          isNormalUser = true;
          description = "${user.fullname}";
          extraGroups = [ "wheel" "networkmanager" ];
          shell = pkgs.zsh;
          # hashedPasswordFile = config.sops.secrets."users/${username}".path;
        };
      };
      # root.hashedPasswordFile = config.sops.secrets."users/root".path;
    };
  };
}
