{ ... }:
{
  imports = [ ./hardware.nix ];

  networking = {
    hostName = "K-Super";
    # hostId = "";
    # nameservers = [ "" "" ];
  };

  kdlt = {
    mainUser = {
      username = "kba";
      fullname = "Kenneth Balboa Aguirre";
      email = "aguirrekenneth@gmail.com";
    };
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
        # unfreePackages = [];
      };
      nixvim = {
      	enable = true;
      };
    };
    graphical = {
      enable = true;
      sound = true;
      laptop = false;
      stylix = {
        enable = true;
      };
      hyprland = {
        enable = true;
      };
      xdg.enable = true;
    };
  };
}
