{ ... }:
{
  imports = [ ./hardware.nix ];

  networking = {
    hostName = "Super";
    # hostId = "";
    # nameservers = [ "" "" ];
  };

  kdlt = {
    stateVersion = "24.05";
    core = {
      btrfs = {
        enable = true;
      };
      wireless = {
        enable = true;
      };
      nvidia = {
        enable = true;
        super = true;
      };
      nix = {
        enableDirenv = false;
        unfreePackages = [];
      };
    };
    graphical = {
      enable = true;
      sound = true;
      laptop = false;
      # stylix = true;
      # hyprland.enable = false;
      xdg.enable = true;
    };
  };
}
