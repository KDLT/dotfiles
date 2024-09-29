# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, user, ... }:
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
      gpu = {
        nvidia = true;
        super = true;
      };
      nixvim = {
        enable = true;
      };
      nix = {
        enableDirenv = false;
        unfreePackages = [];
      };
      routing = {
        enable = true;
      };
    };
    graphical = {
      enable = true;
      sound = true;
      laptop = false;
      hyprland = {
        enable = false;

      };
      xdg = {
        enable = true;
      };
    };
    # somehow in dc-tec's configs development attribute set
    # is not declared in the machine/hostname/default.nix
    # rather it's located in modules/development/default.nix
    # development = {
    #   virtualization = {
    #     docker.enable = true;
    #     k8s.enable = true;
    #     hypervisor.enable = true;
    #   };
    #   git.enable = true;
    #   ansible.enable = true;
    #   go.enable = true;
    #   python312.enable = true;
    #   yamlls.enable = true;
    # };
  };

  # now defined in modules/core/connectivity/printing/default.nix
  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # now defined in nix/default.nix
  # nix.settings = {
  #   experimental-features = [ "nix-command" "flakes" ];
  # };
  #
  # nix.nixPath = [
  #   "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
  #   "nixos-config=/home/kba/dotfiles/configuration.nix"
  #   "/nix/var/nix/profiles/per-user/root/channels"
  # ];

  # # Bootloader. # now defined in ./hardware.nix
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # see ../../modules/core/connectivity/wireless.nix
  # Enable networking
  # networking.networkmanager.enable = true;

  # Set your time zone. # now defined in ../../modules/core/default.nix
  # time.timeZone = "Asia/Manila";
  # Select internationalisation properties.
  # i18n = {
  #   defaultLocale = "en_PH.UTF-8";
  #   extraLocaleSettings = {
  #     LC_ALL = "en_US.UTF-8";
  #     LANGUAGE = "en_US.UTF-8";
  #     LC_TIME = "en_US.UTF-8";
  #   };
  # };

  # now defined in ../../modules/graphical/desktop/hyprland.nix
  # services.xserver = {
  #   enable = true; # Enable the X11 windowing system.
  #   Enable the GNOME Desktop Environment.
  #   displayManager.gdm.enable = true;
  #   desktopManager.gnome.enable = true;
  # };

  # unresolved desktop issur, do not suspend because nvidia
  # now in ../../nvidia.nix
  # services.autosuspend.enable = false;

  # now located in ../../modules/graphical/sound/default.nix
  # # Enable sound with pipewire.
  # hardware.pulseaudio.enable = false;
  # security.rtkit.enable = true;
  # services.pipewire = {
  #   enable = true;
  #   alsa.enable = true;
  #   alsa.support32Bit = true;
  #   pulse.enable = true;
  #   # If you want to use JACK applications, uncomment this
  #   #jack.enable = true;
  #
  #   # use the example session manager (no others are packaged yet so this is enabled by default,
  #   # no need to redefine it in your config for now)
  #   #media-session.enable = true;
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # now in ../../modules/graphical/applications/firefox/default.nix
  # Install firefox.
  # programs.firefox.enable = true;


  ### found in ../../modules/core/shell/zsh.nix
  # enable zsh
  # programs.zsh.enable = true;

  ### found in ../../modules/core/system/default.nix
  # environment.variables = {
  #   EDITOR = "nvim";
  #   VISUAL = "nvim";
  # };

  ### these can largely be found in ../../modules/core/system/default.nix
  # # List packages installed in system profile. To search, run:
  # # $ nix search wget
  # environment.systemPackages = with pkgs; [
  #   # terminalizators
  #   neovim ranger kitty zsh
  #   # filenavigators
  #   fzf ripgrep gcc fd
  #   # outsidenegotiators
  #   wget git curl
  #   # copypastators
  #   xclip
  #   # bling
  #   bat eza oh-my-posh fortune cowsay lolcat
  #   # fetch
  #   disfetch onefetch
  #   # hyprland install
  #   hyprFlake.pkg
  #   # hyprland must haves
  #   qt5.qtwayland qt6.qtwayland
  #   dunst fuzzel # launchers
  #   polkit-kde-agent
  #   # hyprland desktop background
  #   inputs.swww.packages.${pkgs.system}.swww
  #   # hyprland clip & capture
  #   wl-clipboard slurp grim
  # ];
  #
  # now defined in ../../modules/core/shell/default.nix
  # users.defaultUserShell = pkgs.zsh;
  # environment.shells = with pkgs; [
  #   zsh bash
  # ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # now defined in ../../modules/core/utils/sshd/default.nix
  # Enable the OpenSSH daemon.
  #services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).

  # system.stateVersion = "24.05"; # Did you read the comment?
  # ^ stateVersion now defined in ../../modules/core/system/default.nix

  # now defined in ../../modules/core/users/default.nixk
  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users."${user.username}"= {
  #   isNormalUser = true;
  #   description = "${user.fullname}";
  #   extraGroups = [ "networkmanager" "wheel" ];
  #   shell = pkgs.zsh;
  #   # packages = with pkgs; [
  #   #  thunderbird
  #   # ];
  # };

}
