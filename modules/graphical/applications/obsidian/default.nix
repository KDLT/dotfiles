{ config, lib, pkgs, ... }:
let
in
{
  options = {
    kdlt = {
      graphical.applications.obsidian.enable = lib.mkEnableOption "obsidian";
    };
  };

  config = lib.mkIf config.kdlt.graphical.applications.obsidian.enable {
    environment.systemPackages = [ pkgs.obsidian ];
  };
}
