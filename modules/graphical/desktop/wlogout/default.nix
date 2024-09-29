{ lib, config, ...}:
{
  options = {
    kdlt.graphical = {
      wlogout.enable = lib.mkEnableOption "Enable wlogout";
    };
  };

  config = lib.mkIf config.kdlt.graphical.wlogout.enable {

  };
}
