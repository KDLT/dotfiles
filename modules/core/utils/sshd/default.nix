{ config, lib, ... }:
let
in
{
  config = {
    # some zfs, persistence juju here
    # config.kdlt.core.zfs = lib.mkMerge [
    #   (lib.mkIf config.kdlt.persistence.enable {
    #     ensureSystemExists = [ "${config.kdlt.dataPrefix}/etc/ssh" ];
    #   })
    #   (lib.mkIf (!config.kdlt.core.persistence.enable) {})
    # ];

    services.openssh = {
      enable = true;

      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "prohibit-password";

        # remove stale sockets
        StreamLocalBindUnlink = "yes";
      };

      hostkeys = [
        {
          bits = 4096;
          path = "/etc/ssh/ssh_host_rsa_key";
          type = "rsa";
        }
        {
          bits = 4096;
          path = "/etc/ssh/ssh_host_ed25519_key";
          type = "ed25519";
        }
      ];
    };

  };
}
