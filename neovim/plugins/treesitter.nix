{
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;
      nixvimInjections = true;
      settings = {
        highlight.enable = true;
        indent.enable = true;
      };
      folding = false;
    };
    treesitter-refactor = {
      enable = true;
      highlightDefinitions = {
        enable = true;
        # set to false if update time of ~100
        clearOnCursorMove = false;
      };
    };
  };
}
