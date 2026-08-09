{
  gui = true;

  modules = [
    ./hardware-configuration.nix
    ({ ... }: {
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      networking.hostName = "akari";

      networking.networkmanager.enable = true;
      networking.wireless.enable = true;
      services.pipewire = {
        enable = true;
        pulse.enable = true;
      };
      services.libinput.enable = true;

      system.stateVersion = "26.05";
    })

    ({ ... }: {
      services.desktopManager.gnome.enable = true;
      services.displayManager.gdm.enable = true;
    })
  ];

  moduleNames = [
    "cli/ai"
  ];
}
