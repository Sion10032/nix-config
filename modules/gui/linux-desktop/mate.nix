{ pkgs, ... }: {
  services.xserver.desktopManager.mate.enable = true;

  environment.systemPackages = with pkgs; [
  ];
}