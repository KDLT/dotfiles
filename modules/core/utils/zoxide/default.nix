# ~/dotfiles/modules/core/utils/zoxide/default.nix
{ config , ... }: {
  config = {
    home-manager.users.${config.kdlt.mainUser.username} = {
      programs.zoxide = {
        enable = true;
        enableZshIntegration = true;
      };
    };
  };
}
