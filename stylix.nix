{ pkgs, ... }:
let
  monospace = "CommitMono";
  serif = "Go-Mono";
  sansSerif = "JetBrainsMono";
  fonts = name: rec {
    fontName = name;
    pkgName = name + " Nerd Font Mono";
    fontPkg = (pkgs.nerdfonts.override { fonts = [ pkgName ]; });
  };
  # pkg = (pkgs.nerdfonts.override { fonts = [${}]; });
in
{
  test = fonts;

  stylix = {
    enable = true;
    autoEnable = true;
    polarity = "dark";
    image = /home/kba/Pictures/4k-black.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/vesper.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/synth-midnight-dark.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine-moon.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    fonts = {
      monospace = {
        name = monospace;
        # name = fonts monospace.fontName;
        package = (pkgs.nerdfonts.override { fonts = ["CommitMono"]; });
      };
      sansSerif = {
        name = sansSerif;
        package = (pkgs.nerdfonts.override { fonts = ["JetBrainsMono"]; });
      };
      serif = {
        name = serif;
        package = (pkgs.nerdfonts.override { fonts = ["Go-Mono"]; });
      };
      emoji = {
        name = "Noto Emoji";
        package = "";
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
