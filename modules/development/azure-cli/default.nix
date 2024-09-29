{ pkgs, lib, config, user, ... }:
{
  # i choose to not declare these options here but in ../default.nix instead
  options = {};

  config = lib.mkIf config.kdlt.development.azure-cli.enable {
    kdlt.core.zfs = lib.mkMerge [
      (lib.mkIf config.kdlt.core.persistence.enable { homeCacheLinks = [ ".azure" ]; })
      (lib.mkIf (!config.kdlt.core.persistence.enable) {})
    ];

    home-manager.users.${user.username} = {
      # NOTICE: first time i've seen pkgs.stable specifically used
      home.packages = with pkgs.stable; [
        azure-cli
        #bicep
      ];
    };
  };
}
