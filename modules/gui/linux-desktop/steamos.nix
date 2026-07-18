{ inputs, sLib, ... }: sLib.forLinux.attrs {
  imports = [
    inputs.jovian.nixosModules.default
  ];
  jovian.steam = {
    enable = true;
    autoStart = true;
    user = "sion";
    desktopSession = "plasma";
  };
  jovian.hardware.has.amd.gpu = true;

  services.desktopManager.plasma6.enable = true;
}