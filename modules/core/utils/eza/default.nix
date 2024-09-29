# ~/dotfiles/modules/core/utils/eza/default.nix
{ user, ... }:
{
  config = {
    home-manager.users.${user.username} = {
      programs.eza = {
        enable = true;
        enableZshIntegration = true;
        icons = true;
        git = true;
      };
    };
  };
}
