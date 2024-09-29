# ~/dotfiles/modules/core/utils/ripgrep/default.nix
{ user, ... }:
{
  config = {
    # home-manager.${user.username} = {...}: {
    # why is the output not a function like above?

    home-manager.users.${user.username} = {
      programs.ripgrep = {
        enable = true;
      };
    };
  };
}
