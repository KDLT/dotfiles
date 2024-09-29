{  config, lib, user, ... }:
{
  # options = {
  #   kdlt = {
  #     graphical.applications.firefox.enable = lib.mkEnableOption "Firefox";
  #   };
  # };
  config = lib.mkIf config.kdlt.graphical.applications.firefox.enable {
    home-manager.users.${user.username} = {
      programs.firefox = {
        enable = true;
      };
    };
  };
}
