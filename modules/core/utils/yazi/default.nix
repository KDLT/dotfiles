# ~/dotfiles/modules/core/utils/yazi/default.nix
{ user, ... }: { # you CANNOT omit the triple dot syntax when passing an input
  config = {
    home-manager.users.${user.username} = {
      programs.yazi = {
        enable = true;
        enableZshIntegration = true;
        settings = {
          log = {
            enabled = true;
          };
          manager = {
            show_hidden = true;
            sort_by = "modified";
            sort_dir_first = true;
            sort_reverse = true;
          };
        };
        shellWrapperName = "y";
      };
    };
  };
}
