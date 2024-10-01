# ~/dotfiles/modules/core/utils/bottom/default.nix
{ config, ... }:
{
  config = {
    # home-manager.${user.username} = {...}: {
    # why is the output not a function like above?

    home-manager.users.${config.kdlt.mainUser.username} = {
      programs.bottom = {
        enable = true;
      };
    };
  };
}
