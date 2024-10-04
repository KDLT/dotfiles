# ~/dotfiles/modules/core/home-manager/default.nix
{
  config,
  pkgs,
  ...
}: let
  username =  config.kdlt.username;
in
{
  # imports = [];
  # kdlt.core.zfs = lib.mkMerge [
  #   (lib.mkIf config.kdlt.core.persistence.enable {
  #     homeCacheLinks = [ ".config" ".cache" ".local" ".cloudflared" ];
  #   })
  #   (lib.mkIf (!config.dc-tec.core.persistence.enable) {})
  # ];
  # colorScheme = inputs.nix-colors.colorScheme.catpuccin-macchiato;
  # catppuccin.flavor = "macchiato";

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    users = {
      ${username} = {...}: {
        # imports = [ inputs.catppuccin.homeManagerModules.catppuccin ];
        home = {
          stateVersion = config.kdlt.stateVersion;

          homeDirectory = "/home/${username}";

          packages = with pkgs; [
            libnotify # sends desktop notifs to notif daemon
            wireguard-tools # secure tunneling whatever that means

            ventoy # endgame bootable usb
          ];
        };
      };

      root = _: { # the underscore colon _: might just be the same as {...}:
        home.stateVersion = config.kdlt.stateVersion;
      };
    };


  };
}
