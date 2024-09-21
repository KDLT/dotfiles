# shell.nix
{ pkgs, ... }:
let
  myAliases = ''
    ll = "eza --icons -lTa -L=1";
    cat = "bat";
    gitfetch = "onefetch";
    fetch = "disfetch"
  '';
in
{

  home.packages = with pkgs; [
    zsh bash fish
    eza bat onefetch disfetch
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
  };

  programs.bash = { shellAliases = myAliases; };
  programs.fish = { shellAliases = myAliases; };

}
