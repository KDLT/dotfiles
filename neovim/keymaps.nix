{ config, lib, ... }:
{
  programs.nixvim = {
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    keymaps = let
      # mappings on normal mode
      normal =
        lib.mapAttrsToList (key: action: {
          mode = "n";
          inherit action key;
        })
        {
          "<Space>" = "<NOP>"; # to not interfere with space being the leader key
          "<Esc>" = ":noh<CR>"; # clear highlights
          "L" = "$"; # go to last character of line
          "H" = "^"; # go to first non-empty character of line

          "<C-c>" = ":b#<CR>"; # back and forth between two most recent files
          "<C-x>" = ":close<CR>"; # close window via Ctrl+x, this cannot close the last window

          "<leader>s" = ":w<CR>"; # save buffer via Space s
          "<C-s>" = ":w<CR>"; # save buffer via Ctrl+s

          "<leader>h" = "<C-w>h"; # navigate to left window
          "<leader>j" = "<C-w>j"; # navigate to bottom window
          "<leader>k" = "<C-w>k"; # navigate to top window
          "<leader>l" = "<C-w>l"; # navigate to right window

          "<C-Up>" = ":resize +2<CR>"; # grow horizontal current window
          "<C-Down>" = ":resize -2<CR>"; # shrink horizontal current window
          "<C-Left>" = ":vertical resize -2<CR>"; # shrink vertical current window
          "<C-Right>" = ":vertical resize +2<CR>"; # grow vertical current window
        };
      visual =
        lib.mapAttrsToList (key: action: {
          mode = "v";
          inherit action key;
        })
        {
          # keeps the highlight intact after indenting
          ">" = ">gv";
          "<TAB>" = ">gv";
          "<" = "<gv";
          "<S-TAB>" = "<gv";

          # move selected line/block of text in visual mode
          "K" = ":m '<-2<CR>gv=gv"; #
          "J" = ":m '>+1<CR>gv=gv"; #
        };
    in
      config.lib.nixvim.keymaps.mkKeymaps
      { options.silent = true; }
      ( normal ++ visual );
  };
}
