{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    ./stylix.nix
    ./neovim
    ./kitty.nix
    ./hyprland.nix
    ./waybar.nix
    ./shell.nix
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "kba";
  home.homeDirectory = "/home/kba";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  programs.git = {
    enable = true;
    userEmail = "aguirrekenneth@gmail.com";
    userName = "kba";
  };

  # nixpkgs.overlays = [
  #   inputs.kickstart-nix-nvim.overlays.default
  # ];

  xdg.enable = true;
  xdg.userDirs.createDirectories = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    fzf
    btop
    bat
    nerdfonts
    python3
    ripgrep
    gcc
    xclip
    fd
  ];

  programs.ranger = {
    enable = true;
    extraConfig = ''
      # set preview_images true
    '';
    settings = {
      column_ratios = "1,3,3";
      scroll_offset = 8;
      unicode_ellipsis = true;
      preview_images = true;
      preview_images_method = "kitty";
    };
  };

  programs.btop = {
    enable = true;
    settings = {
      vim_keys = true;
    };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = { };

  home.sessionVariables = {
    # EDITOR = "emacs";
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
