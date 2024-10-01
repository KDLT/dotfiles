# ~/dotfiles/modules/core/utils/eza/default.nix
{ config, ... }:
{
  config = {
    home-manager.users.${config.kdlt.mainUser.username} = {
      programs.eza = {
        enable = true;
        enableZshIntegration = true;
        icons = true;
        git = true;
      };
    };
  };
}
