# ~/dotfiles/modules/core/utils/bottom/default.nix
{ user, ... }:
{
  config = {
    # home-manager.${user.username} = {...}: {
    # why is the output not a function like above?

    home-manager.${user.username} = {
      programs.btop = {
        enable = true;
        settings = {
          vim_keys = true;
        };
      };
    };
  };
}
