{ ... }:
let
in
{
  imports = [
    ./options.nix
    ./keymaps.nix
    ./colorscheme.nix
    ./completions.nix
    ./plugins
  ];

  home.shellAliases.v = "nvim";

  programs.nixvim = {
    enable = true;
    enableMan = true; # enable nixvim manual
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    luaLoader.enable = true;

    # cmd [[hi Normal guibg=NONE ctermbg=NONE]]
    performance = {
      combinePlugins = {
        enable = true;
        standalonePlugins = [
          "hmts.nvim"
          "nvim-treesitter"
          "lualine.nvim"
        ];
      };
      byteCompileLua.enable = true;
    };
  };

}
