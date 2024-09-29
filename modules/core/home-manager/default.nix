{ config, inputs, lib, pkgs, user, ... }:
let
  username = user.userName;
in
{
  home-manager = {

    useGlobalPkgs = true;
    useUserPkgs = true;

    users.${username} = { ... }: {
      imports = [];
      home = {
        stateVersion = config.${username}.stateVersion;
        homeDirectory = "/home/${username}";
        # packages = [ inputs.nixvim.packages.x86_64-linux.default ];
        systemd.user = {
          sessionVariables = config.home-manager.users.${username}.home.sessionVariables;
        };
      };
    };

    users.root = _: { # the underscore colon _: might just be the same as {...}:
      home.stateVersion = config.${username}.stateVersion;
    };

  };
}
