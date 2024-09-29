{ config, lib, user, ... }:
let
  username = user.username;
  userhome = "/home/" + username;
  dataPrefix = "${config.kdlt.dataPrefix}";
in
{
  config = {
    # kdlt.core.zfs = lib.mkMerge [
    #   (lib.mkIf config.kdlt.core.persistence.enable {
    #     homeDataLinks = [
    #       {
    #         directory = ".ssh";
    #         mode = "0700";
    #       }
    #     ];
    #     systemDataLinks = [
    #       {
    #         directory = "/root/.ssh/";
    #         mode = "0700";
    #       }
    #     ];
    #   })
    #   (lib.mkIf (!config.kdlt.core.persistence.enable))
    # ];

    home-manager.users.${username} = { ... }: {
      programs.ssh = {
        enable = true;
        # startAgent = true; # TODO: you pretend this does option does not exist
        # hashKnownHosts = true;
        userKnownHostsFile =
          if config.kdlt.core.persistence.enable
          then  "${dataPrefix}/${userhome}/.ssh/known_hosts"
          else "${userhome}/.ssh/known_hosts";
        extraOptionOverrides = {
          AddKeysToAgent = "yes";
          IdentityFile =
            if config.kdlt.core.persistence.enable
            then  "${dataPrefix}/${userhome}/.ssh/id_ed25519"
            else "${userhome}/.ssh/id_ed25519";
        };
      };

      services.ssh-agent = {
        enable = true;
      };
    };
  };
}
