{ config, lib, ... }:
let
in
{
  options = {
    kdlt = {
      graphical.sound = lib.mkEnableOption "sound on?";
    };
  };

  config = lib.mkIf config.kdlt.sound.enable {
    security.rtkit.enable = true;

    # my guess is this creates a custom module that can be found in
    # /etc/wireplumber/bluetooth.lua.d/51-bluez-config.lua
    environment.etc = {
      "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
        bluez_monitor.properties = {
          ["bluez5.enable-sbc-xq"] = true,
          ["bluez5.enable-msbc"] = true,
          ["bluez5.enable-hw-volume"] = true,
          ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]",
        }
      '';
    };

    hardware = {
      pulseaudio.enable = true;
      bluetooth = {
        enable = true;
        settings = {
          General = "Control,Gateway,Headset,Media,Sink,Socket,Source";
          MultiProfile = "multiple";
        };
      };
    };

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
      # jack.enable = true;
      # media-session.enable = true;
    };

  };
}
