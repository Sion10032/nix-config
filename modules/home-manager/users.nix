{ lib, sLib, users, ... }: let
  getUserConfig = user: {
    home-manager.users.${user} = { ... }: {
      home.username = user;
    }
    // sLib.forDarwin.attrs {
      targets.darwin = {
        linkApps.enable = false;
        copyApps.enable = true;
      };
    };
  };
in
  lib.mergeAttrsList (lib.map getUserConfig users)
