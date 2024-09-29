# ~/dotfiles/modules/graphical/stylix/default.nix
{  config, lib, pkgs, ... }:
let
  monospace = "CommitMono";
  serif = "Go-Mono";
  sansSerif = "JetBrainsMono";
  fonts = name: rec {
    cleanName = (builtins.replaceStrings [ "-" ] [ "" ] name);
    fontName = cleanName + " Nerd Font Mono";
    fontPkg = (pkgs.nerdfonts.override { fonts = [ name ]; });
  };
in
{
  # now defined in ../default.nix, SIKE
  options = {
    kdlt = {
      graphical.stylix = lib.mkEnableOption "Use Stylix";
    };
  };

  config = lib.mkIf config.kdlt.graphical.stylix {
    # im letting stylix handle everything
    stylix = {
      enable = true;
      autoEnable = true;
      polarity = "dark";
      image = /home/kba/Pictures/aesthetic-wallpapers/images/manga.png;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/vesper.yaml";
      fonts = {
        monospace.name = (fonts monospace).fontName;
        monospace.package = (fonts monospace).fontPkg;
        sansSerif.name = (fonts sansSerif).fontName;
        sansSerif.package = (fonts sansSerif).fontPkg;
        serif.name = (fonts serif).fontName;
        serif.package = (fonts serif).fontPkg;
        emoji = {
          name = "Noto Emoji";
          package = pkgs.noto-fonts-monochrome-emoji;
        };
        sizes = {
          terminal = 18;
          applications = 14;
          popups = 12;
          desktop = 14;
        };
      };
    };
  };
}
