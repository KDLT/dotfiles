# ~/dotfiles/modules/core/utils/gpg/default.nix
{ user, lib, pkgs, ... }:
{
  config = {
    # kdlt.core.zfs = lib.mkMerge [
    #   (lib.mkIf config.kdlt.core.persistence.enable {
    #     homeDataLinks = [
    #       {
    #         directory = ".gnupg";
    #         mode = "0700";
    #       }
    #     ];
    #   })
    #   (lib.mkIf (!config.kdlt.core.persistence.enable) {})
    # ];

    environment.systempackages = with pkgs; [
      gnupg
      pinetry-gtk2
    ];

    home-manager.${user.username} = {
      services.gpg-agent = {
        enable = true;
        enableZshIntegration = true;
        enableSshSupport = true;
        pinetryPackage = pkgs.pinetry-gtk2;
        defaultCacheTtl = 46000;
        extraConfig = ''
          allow-preset-passphrase
        '';
      };
    };
  };
}
