{
  imports = [
    ./telescope.nix
    ./startify.nix
    ./lualine.nix
    ./lsp.nix
    ./harpoon.nix
    ./treesitter.nix
    ./comment.nix
    ./which-key.nix
    ./oil.nix
    ./undotree.nix
    ./dap.nix
  ];

  programs.nixvim = {
    plugins = {
      nvim-autopairs.enable = true;

      nvim-colorizer = {
        enable = true;
        userDefaultOptions.names = false;
      };

      # highlights whitespaces and trim them upon save
      trim = {
        enable = true;
        settings = {
          highlight = true;
          highlight_bg = "#303030";
          # highlight_ctermbg = "gray";
          ft_blocklist = [
            "checkhealth"
            # "floaterm"
            # "lspinfo"
            # "neo-tree"
            "TelescopePrompt"
          ];
        };
      };
    };
  };
}
