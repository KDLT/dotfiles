# ~/dotfiles/modules/core/utils/eza/default.nix
{ user, ... }:
{
  config = {
    home-manager.${user.username} = {
      programs.eza = {
        enable = true;
        enableZshIntegration = true;
        icons = true;
        git = true;
      };
    };
  };
}
