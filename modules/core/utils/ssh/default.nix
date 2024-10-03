{ config, lib, ... }:
let
  username = config.kdlt.mainUser.username;
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
        matchBlocks = {
          K-Nixpad = {
            hostname = "192.168.1.54";
            user = "kba";
            identityFile = "~/.ssh/id_rsa_K-Super";
          };
          # "git@github.com" = {
          "git-ssh" = {
            hostname = "github.com";
            user = "git";
            identityFile = "~/.ssh/id_rsa_K-Super";
          };
        };
        userKnownHostsFile =
          if config.kdlt.core.persistence.enable
          then  "${dataPrefix}/home/${username}/.ssh/known_hosts"
          else "${userhome}/.ssh/known_hosts";
        extraOptionOverrides = {
          AddKeysToAgent = "yes";
          IdentityFile =
            if config.kdlt.core.persistence.enable
            then  "${dataPrefix}/home/${username}/.ssh/id_ed25519"
            else "${userhome}/.ssh/id_ed25519";
        };
      };

      services.ssh-agent = {
        enable = true;
      };
    };
  };
}
