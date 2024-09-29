{ config, lib, pkgs, user, ... }:
let
in
{
  imports = [
    ./lazy_git.nix
    ./github.nix
  ];

  options = {
    kdlt.development.git = {
      enable = lib.mkEnableOption "enable github";
      username = lib.mkOption { default = user.username; };
      email = lib.mkOption { default = user.email; };
    };
  };

  config =
    # git config in a let binding to allow declaration in multiple userspaces
    let
      kdlt-git = {
        programs.git = {
          enable = true;
          userName = user.username;
          userEmail = user.email;

          # TODO: git configs i'm not familiar with yet so commented out
          # extraConfig = {
          #   init.defaultBranch = "main";
          #   push.autoSetupRemote = true;
          #   pull.rebase = true;
          #
          #   user.signingkey = "";
          #   commit.gpgsign = true;
          #   gpg.program = "${pkgs.gnupg}/bin/gpg2";
          #
          #   url = {
          #     "ssh://git@github.com/kdlt" = {
          #       insteadOf = "https://github.com/kdlt";
          #     };
          #   };
          #
          #   github.user = "kdlt";
          #   safe.directory = "/home/${username}/code/github/test/.git";
          # };

        };
      };
    in
    {
      # see the multiple userspaces here
      home-manager.users.${user.username} = {...}: kdlt-git;
      home-manager.users.root = {...}: kdlt-git;
    };
}
