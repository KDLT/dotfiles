{
  programs.nixvim = {

    plugins.telescope = {
      enable = true;
      keymaps = {
        # find files using telescope command line "sugar"
        "<leader>ff" = "find_files";
        "<leader>fg" = "live_grep";
        "<leader>b" = "buffers";
        "<leader>fh" = "help_tags";
        "<leader>fd" = "diagnostics";
        "<leader>fk" = "keymaps";

        # my Ctrl based bindings
        "<C-p>" = "git_files";
        "<leader>o" = "oldfiles";
        "<C-f>" = "find_files";
        "<C-g>" = "live_grep";
      };

      settings.defaults = {
        file_ignore_patterns = [
          "^.git/"
          "^.mypy_cache/"
          "^__pycache__/"
          "^output/"
          "^data/"
          "^.ipynb"
        ];
        set_env.COLORTERM = "truecolor";
      };
    };
  };
}
