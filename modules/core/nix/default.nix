{ config, lib, ...}:
let
  username = config.kdlt.mainUser.username;
in
{
  options = {
    kdlt.core.nix = {
      enableDirenv = lib.mkOption { default = true; }; # TODO this should not be commented out
      unfreePackages = lib.mkOption { default = []; }; # TODO this conflicts with nvidia unfree
    };
  };

  config = {
    # kdlt.core.zfs = lib.mkMerge [
    #   (lib.mkIf config.kdlt.persistence.enable {
    #     homeCacheLinks = [ "local/share/direnv" ];
    #     systemCacheLinks = [ "/root/.local/share/direnv" ];
    #     systemDataLinks = [ "/var/lib/nixos" ];
    #   })
    #   (lib.mkIf (!config.kdlt.core.persistence.enable) {})
    # ];

    programs.nh = {
      enable = true;
      clean.enable = false;
      flake = "/home/${username}/dotfiles";
    };

    nixpkgs.config = {
      allowUnfree = true;
    };

    nix = {
      settings = {
        trusted-users = [ username "@wheel" ];
        experimental-features = [ "nix-command" "flakes" ];
        warn-dirty = false;
      };

      # garbage collect
      gc = {
        automatic = true;
        dates = "daily";
        options = "--delete-older-than 7d";
      };

      nixPath = [
        "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
        "nixos-config=/home/kba/dotfiles/machines/Super/default.nix"
        "/nix/var/nix/profiles/per-user/root/channels"
      ];
    };

  };
}
