{ pkgs, lib, config, user, ... }:
{
  # i choose to not declare these options here but in ../default.nix instead
  options = {};

  config = lib.mkIf config.kdlt.development.virtualization.docker.enable {
    # kdlt.core.zfs.systemCacheLinks = [ "/opt/docker" ];

    users.users.${user.username}.extraGroups = [ "docker" ];

    virtualisation.docker = {
      enable = true;
      extraOptions = "--data-root ${config.kdlt.dataPrefix}/var/lib/docker";
      # storageDriver = "zfs"; # changing storage drivers will turn current images inaccessible
    };

    home-manager.users.${user.username} = {
      home.packages = [
        pkgs.python312
        # pkgs.python312Full # i wonder what full means
      ];
    };

  };
}
