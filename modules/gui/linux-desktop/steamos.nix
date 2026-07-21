{ inputs, pkgs, sLib, ... }: sLib.forLinux.attrs {
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

  services.desktopManager.plasma6 = {
    enable = true;
    enableQt5Integration = true;
  };
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    ark
    discover
    elisa
    khelpcenter
    konsole
    ktexteditor
    okular
    qrca
  ];
  environment.systemPackages = with pkgs; [
    klassy
    fluent-gtk-theme
    papirus-icon-theme
  ];
}