{ config, lib, pkgs, ... }:
{
  # Where most declarations from configuration.nix reside, e.g., timezone, system packages
  options = {
    kdlt = {
      stateVersion = lib.mkOption {
        example = "24.05";
      };
      # these are declared in ../storage/
      # dataPrefix = lib.mkOption {
      #   example = "/data";
      # };
      # cachePrefix = lib.mkOption {
      #   example = "/cache";
      # };
    };
  };

  config = {

    system = {
      stateVersion = config.kdlt.stateVersion;
      autoUpgrade = {
        enable = lib.mkDefault true;
        flake = "github:KDLT/dotfiles";
        dates = "01/04:00";
        randomizedDelaySec = "15min";
      };
    };

    environment = {
      systemPackages = with pkgs; [
        coreutils dnsutils moreutils usbutils util-linux
        direnv lshw nmap whois unzip age sops ssh-to-age
        fastfetch tlrc jdk yq openssl

        wget git curl
        neovim ranger kitty zsh
        fzf ripgrep gcc fd
        xclip
        bat eza oh-my-posh fortune cowsay lolcat
        disfetch onefetch

        # inputs.nixvim.packages.x86_64-linux.default
      ];

      variables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
        DEFAULT_BROWSER = "${pkgs.firefox}/bin/firefox";
      };
    };

    security = {
      sudo.enable = true;
      doas = {
        enable = true;
        extraRules = [
          { # these users would not be required to enter passwords
            users = [ "${config.kdlt.mainUser.username}" ];
            noPass = true;
          }
        ];
      };
      polkit.enable = true;
    };

    # dbus services that allows applications to update firmware
    services.fwupd.enable = true;

    time.timeZone = "Asia/Manila";

    i18n = {
      defaultLocale = "en_PH.UTF-8";
      extraLocaleSettings = {
        LC_ALL = "en_US.UTF-8";
        LANGUAGE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
      };
    };
  };
}
