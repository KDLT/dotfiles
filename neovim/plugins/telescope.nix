{
  programs.nixvim = {

    plugins.telescope = {
      enable = true;
      keymaps = {
        # find files using telescope command line "sugar"
        "<leader>ff" = { action = "find_files";
          options = { desc = "Telescope Files from ./"; };
        };
        "<leader>fg" = { action = "live_grep";
          options = { desc = "Telescope Grep from ./"; };
        };
        "<leader>b" = { action = "buffers";
          options = { desc = "Telescope Buffers"; };
        };
        "<leader>fh" = { action = "help_tags";
          options = { desc = "Telescope Help Tags"; };
        };
        "<leader>fd" = { action = "diagnostics";
          options = { desc = "View Workspace Diagnostics"; };
        };
        "<leader>fk" = { action = "keymaps";
          options = { desc = "View Keymaps but this fails with Harpoon enabled :("; };
        };
        "<leader>o" = { action = "oldfiles";
          options = { desc = "Telescope Previously Opened Files"; };
        };

        # my Ctrl based bindings
        "<C-p>" = { action = "git_files";
          options = { desc = "Telescope Git Files"; };
        };
        "<C-f>" = { action = "find_files";
          options = { desc = "Telescope Files from ./"; };
        };
        "<C-g>" = { action = "live_grep";
          options = { desc = "Live Grep from ./"; };
        };
      };

      settings.defaults = {
        file_ignore_patterns = [
          "^/nix/store/" # i don't want old files populated by nix/store
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
