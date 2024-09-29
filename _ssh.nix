{ ... }:
{
  config = {
    home-manager.users.kba = {

      programs.ssh = {
        startAgent = true;
        knownHosts = {
          "K-Nixpad".publicKeyFile = ../.ssh/id_rsa_K-Nixtop.pub;
        };
        userKnownHostsFiles = "~/.ssh/known_hosts";
      };

      services.ssh-agent = {
        enable = true;
      };

    };
  };
}
