# ~/dotfiles/modules/core/utils/fzf/default.nix
{ config, ... }:
{
  config = {
    home-manager.users.${config.kdlt.mainUser.username} = {
      programs.fzf = {
        enable = true;
        enableZshIntegration = true;
      };
    };
  };
}
