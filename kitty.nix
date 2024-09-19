{ lib, ... }:
{
  programs.kitty = {
    enable = true;
    # font = {
    #   size = 18;
    # };
    # theme = "Space Grey Eighties";
    settings = {
      # lib.mkForce is required to set opacity
      background_opacity = lib.mkForce "0.89";
      window_padding_width = "12";
      enabled_layouts = "tall, splits, fat";
      inactive_border_color = "#0f0d0d";
      active_border_color = "#ffebeb";
      # tab settings
      tab_bar_style = "powerline";
      tab_powerline_style = "round";
    };
  };
}
