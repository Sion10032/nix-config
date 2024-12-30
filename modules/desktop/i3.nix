{ config, pkgs, ... }: {
  imports = [
    ./x.nix
  ];

  services.xserver.windowManager.i3 = {
    enable = true;
    extraPackages = [];
  };
  services.displayManager.defaultSession = "none+i3";
}
