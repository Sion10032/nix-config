{ lib, sLib, pkgs, users, ... }: let
  getLinuxConfigs = user: sLib.forLinux.attrs {
    home = "/home/${user}";
    extraGroups = [ "wheel" ]; # Enable 'sudo' for the user.
    isNormalUser = true;
  };
  getDarwinConfigs = user: sLib.forDarwin.attrs {
    home = "/Users/${user}";
  };
  getUserConfig = user: {
    users.users."${user}" = lib.mergeAttrsList [
      ({
        shell = pkgs.fish;
        ignoreShellProgramCheck = true;
      })
      (getLinuxConfigs user)
      (getDarwinConfigs user)
    ];
  };
in
  lib.mergeAttrsList (lib.map getUserConfig users)
