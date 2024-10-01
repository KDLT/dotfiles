# modules/core/shells/zsh/default.nix
{ pkgs, lib, config, ...}:
let
  username = config.kdlt.mainUser.username;
  myAliases = {
    ll = "eza --icons -lTa -L=1";
    cat = "bat";
    gitfetch = "onefetch";
    fetch = "disfetch";
    icat = "kitten icat";
  };
in
{
  options = {};
  config = {

    # kdlt.core.zfs = lib.mkMerge [
    #   (lib.mkIf config.kdlt.core.persistence.enable {
    #     systemCacheLinks = ["/root/.local/share/autojump"];
    #     homeCacheLinks = [".local/share/autojump"];
    #   })
    # ];

    programs.zsh.enable = true;

    home-manager.users = {
      ${username} = {

        home.packages = with pkgs; [
          comma # run package without installing them
          onefetch # git repo summary on terminal
          disfetch # less complex neofetch
        ];

        programs = {
          zsh.enable = true;
          bash.enable = true;
          fish.enable = false;
          zoxide.enable = true;
          fzf.enable = true;
          thefuck.enable = true;
          direnv.enable = true;
        };

        programs.zsh = {
          dotDir = ".config/zsh";
          defaultKeymap = "viins";
          completionInit = "autoload -Uz compinit";
          enableCompletion = true;
          syntaxHighlighting.enable = true;
          autosuggestion.enable = true;
          historySubstringSearch.enable = true;
          history = {
            path = "$HOME/.config/zsh/histfile";
            save = 10000;
            extended = true;
          };
          initExtraBeforeCompInit = ''
      setopt HIST_IGNORE_DUPS SHARE_HISTORY HIST_FCNTL_LOCK EXTENDED_HISTORY EXTENDED_GLOB NOTIFY
      unsetopt AUTO_CD BEEP NOMATCH
          '';
          shellAliases = myAliases;
          envExtra = ''disfetch'';
          loginExtra = "hyprland";
        };

        programs.bash = { shellAliases = myAliases; };
        programs.fish = { shellAliases = myAliases; };
      };
    };
  };
}
