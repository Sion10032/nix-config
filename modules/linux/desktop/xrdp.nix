{ config, lib, ... }: let
  defaultSession = config.services.displayManager.defaultSession;
in {
  services.xrdp = {
    enable = true;
    audio.enable = false;
    defaultWindowManager = "i3";
  };
}
