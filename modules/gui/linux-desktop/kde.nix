{ pkgs, ... }: {
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
    papirus-icon-theme
    colloid-icon-theme
  ];
}
