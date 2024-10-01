# ~/dotfiles/modules/core/home-manager/default.nix
{ config, ... }:
let
  username =  config.kdlt.mainUser.username;
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
          # homeDirectory = "/home/${username}"; # some error about conflicting declaration here
          # packages = [];

          # TODO: Infinite recursion gets triggered here, this is the culprit
          # systemd.user = {
          #   sessionVariables = config.home-manager.users.${username}.home.sessionVariables;
          # };
        };
      };

      root = _: { # the underscore colon _: might just be the same as {...}:
        home.stateVersion = config.kdlt.stateVersion;
      };
    };


  };
}
