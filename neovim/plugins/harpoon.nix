{
  programs.nixvim.plugins.harpoon = {
    enable = false;
    enableTelescope = true;
    keymapsSilent = false;
    keymaps = {
      addFile = "<leader>a";
      toggleQuickMenu = "<C-e>";
      navFile = {
        # "1" = "<C-j>";
        # "2" = "<C-k>";
        # "3" = "<C-l>";
        # "4" = "<C-;>";
        "1" = "<C-1>";
        "2" = "<C-2>";
        "3" = "<C-3>";
        "4" = "<C-4>";
        "5" = "<C-5>";
        "6" = "<C-6>";
      };
    };
  };
}
