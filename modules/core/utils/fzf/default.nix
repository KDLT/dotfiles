# ~/dotfiles/modules/core/utils/fzf/default.nix
{ user, ... }:
{
  config = {
    home-manager.${user.username} = {
      programs.fzf = {
        enable = true;
        enableZshIntegration = true;
      };
    };
  };
}
