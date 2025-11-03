{ config, lib, pkgs, ... }: let
  linuxConfigs = {
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    isNormalUser = true;
  };
  darwinConfigs = {
  };
  getHomePath = user: if pkgs.stdenv.isDarwin then "/Users${user}" else "/home/${user}";
in {
  users.users.sion = lib.mergeAttrsList [
    ({
      home = getHomePath "sion";
      shell = pkgs.fish;
    })
    (lib.optionalAttrs (pkgs.stdenv.isLinux) linuxConfigs)
    (lib.optionalAttrs (pkgs.stdenv.isDarwin) darwinConfigs)
  ];
}

