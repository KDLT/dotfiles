{ lib, config, ...}:
{
  options = {
    kdlt.graphical = {
      anyrun.enable = lib.mkEnableOption "Enable Anyrun";
    };
  };

  config = lib.mkIf config.kdlt.graphical.anyrun.enable {

  };
}
