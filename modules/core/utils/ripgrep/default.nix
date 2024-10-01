# ~/dotfiles/modules/core/utils/ripgrep/default.nix
{ config, ... }:
{
  config = {
    # home-manager.${user.username} = {...}: {
    # why is the output not a function like above?

    home-manager.users.${config.kdlt.mainUser.username} = {
      programs.ripgrep = {
        enable = true;
      };
    };
  };
}
