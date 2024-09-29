# ~/dotfiles/modules/core/utils/zoxide/default.nix
{ user, ... }: {
  config = {
    home-manager.users.${user.username} = {
      programs.zoxide = {
        enable = true;
        enableZshIntegration = true;
      };
    };
  };
}
