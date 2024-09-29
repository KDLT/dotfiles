{ pkgs, lib, config, user }:
{
  # i choose to not declare these options here but in ../default.nix instead
  options = {};

  config = lib.mkIf config.kdlt.development.python312.enable {
    home-manager.users.${user.username} = {
      home.packages = [
        pkgs.python312
        # pkgs.python312Full # i wonder what full means
      ];
    };
  };
}
