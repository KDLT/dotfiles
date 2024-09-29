# ~/dotfiles/modules/core/utils/direnv/default.nix
{ config, lib, user, ... }:
{
  config = {
    home-manager.${user.username} = {
      programs.direnv = {
        enable = lib.mkIf config.kdlt.core.nix.enableDirenv true;
        enableZshIntegration = true;
        nix-direnv.enable = true;
      };
    };
  };
}
