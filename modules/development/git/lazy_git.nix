# ~/dotfiles/modules/development/git/lazy_git.nix
{ user, ... }:
let
  kdlt-lazygit = homeDir: {
    programs.lazygit = {
      enable = true;
      settings = {
        overrideGpg = true;
      };
    };
  };
in
{
  home-manager.users.${user.username} = _: kdlt-lazygit "/home/${user.username}";
}
