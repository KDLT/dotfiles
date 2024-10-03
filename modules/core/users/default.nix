# ~/dotfiles/modules/core/users/default.nix
{ config, lib, pkgs, user, ... }:
{
  # TODO: i want to declare username in the machines/<>/default.nix instead of the topmost flake
  # this is the option to enable this attribute
  options = {
    kdlt.mainUser = {
      username = lib.mkOption {
        default = "${user.username}";
        type = lib.types.str;
        example = "kba";
      };
      fullname = lib.mkOption {
        default = "${user.fullname}";
        type = lib.types.str;
        example = "Kenneth Balboa Aguirre";
      };
      email = lib.mkOption {
        default = "${user.email}";
        type = lib.types.str;
        example = "aguirrekenneth@gmail.com";
      };
    };
  };

  config = {
    users = {
      # true is default, TODO: set to false after
      # implementing secrets management, see hashedPasswordFile commented lines below
      mutableUsers = true;
      users = {
        # ${user.username} = { # this is the original "known working" declaration
        ${config.kdlt.mainUser.username} = { # this is a different declaration from the rest of the config
          isNormalUser = true;
          # description = "${user.fullname}"; # this is the original "known working" declaration
          description = "${config.kdlt.mainUser.fullname}";
          extraGroups = [ "wheel" "networkmanager" ];
          shell = pkgs.zsh;
          # hashedPasswordFile = config.sops.secrets."users/${username}".path;
        };
      };
      # root.hashedPasswordFile = config.sops.secrets."users/root".path;
    };
  };
}
