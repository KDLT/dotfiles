# ~/dotfiles/modules/core/utils/bat/default.nix
{ user, pkgs, ... }:
{
  config = {
    # home-manager.${user.username} = {...}: {
    # why is the output not a function like above?

    home-manager.users.${user.username} = {
      programs.bat = {
        enable = true;
        # TODO: test if pkgs.bat is not required, eliminating the need for pkgs in the inputs
        package = pkgs.bat;
      };
    };
  };
}
