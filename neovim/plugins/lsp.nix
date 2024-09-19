{
  programs.nixvim.plugins = {
    lsp-format.enable = true;

    lsp = {
      enable = true;
      keymaps = {
        silent = true;
        diagnostic = {
          # navigate diagnostics
          "<leader>[" = "goto_prev";
          "<leader>]" = "goto_next";
        };
        lspBuf = {
          gd = "definition";
          gD = "references";
          gt = "type_definition";
          gi = "implementation";
          K = "hover";
          "<F2>" = "rename";
        };
      };

      servers = {
        clangd.enable = true;
        texlab.enable = true;
        lua-ls.enable = true;
        nixd.enable = true;
        pylsp.enable = true;
      };
    };
  };
}
