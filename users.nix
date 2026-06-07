{ config, lib, pkgs, users, ... }: let
  linuxConfigs = {
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    isNormalUser = true;
  };
  darwinConfigs = {
  };
  getHomePath = user: if pkgs.stdenv.isDarwin then "/Users/${user}" else "/home/${user}";
  getUserConfig = user: {
    users.users."${user}" = lib.mergeAttrsList [
      ({
        home = getHomePath user;
        shell = pkgs.fish;
        ignoreShellProgramCheck = true;
      })
      (lib.optionalAttrs (pkgs.stdenv.isLinux) linuxConfigs)
      (lib.optionalAttrs (pkgs.stdenv.isDarwin) darwinConfigs)
    ];
  };
in
  lib.mergeAttrsList (lib.map getUserConfig users)
