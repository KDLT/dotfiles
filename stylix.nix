{ pkgs, ... }:
let
  monospace = "CommitMono";
  # monospace = "Go-Mono";
  serif = "Go-Mono";
  sansSerif = "JetBrainsMono";
  fonts = name: rec {
    cleanName = (builtins.replaceStrings [ "-" ] [ "" ] name);
    fontName = cleanName + " Nerd Font Mono";
    fontPkg = (pkgs.nerdfonts.override { fonts = [ name ]; });
  };
in
{
  stylix = {
    enable = true;
    autoEnable = true;
    polarity = "dark";
    # image = /home/kba/Pictures/4k-black.jpg;
    image = /home/kba/Pictures/aesthetic-wallpapers/images/manga.png;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/vesper.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/synth-midnight-dark.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine-moon.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
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

}
