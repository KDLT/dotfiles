{ pkgs, lib, config, user, ... }:
{
  # i choose to not declare these options here but in ../default.nix instead
  options = {};

  config = lib.mkIf config.kdlt.development.powershell.enable {
    home-manager.users.${user.username} = {
      home.packages = [ pkgs.powershell ];
    };
  };
}
