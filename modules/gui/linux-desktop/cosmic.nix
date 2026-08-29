{ pkgs, ... }: {
  services.desktopManager.cosmic = {
    enable = true;
    xwayland.enable = true;
  };

  environment.cosmic.excludePackages = with pkgs; [
    cosmic-player
    cosmic-reader
  ];

  environment.systemPackages = with pkgs; [
    cosmic-ext-ctl
    cosmic-ext-applet-sysinfo
    cosmic-ext-applet-minimon
    cosmic-ext-applet-caffeine

    nemo
  ];
}
