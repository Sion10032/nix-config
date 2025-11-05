{ lib, users, ... }: let
  getUserConfig = user: {
    home-manager.users.${user} = { pkgs, lib, ... }: {
      home.username = user;

      targets.darwin = lib.mkIf pkgs.stdenv.isDarwin {
        linkApps.enable = false;
        copyApps.enable = true;
      };
    };
  };
in
  lib.mergeAttrsList (lib.map getUserConfig users)
