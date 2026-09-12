{
  gui = true;

  modules = [
    ./hardware-configuration.nix
    ({ pkgs, ... }: {
      boot.loader.systemd-boot = {
        enable = true;
        edk2-uefi-shell.enable = true;
        extraFiles = {
          # driver from https://github.com/jlobue10/UsbXbox360Dxe
          "EFI/systemd/drivers/UsbXbox360Dxe-x64.efi" = ./UsbXbox360Dxe-x64.efi;
        };
      };
      boot.loader.efi.canTouchEfiVariables = true;

      boot.kernelPackages = pkgs.linuxPackages_latest;

      networking.hostName = "ally";

      networking.networkmanager.enable = true;
      networking.wireless.enable = true;
      services.pipewire = {
        enable = true;
        pulse.enable = true;
      };
      services.libinput.enable = true;

      services.power-profiles-daemon.enable = true;
      services.upower.enable = true;

      system.stateVersion = "26.11";
    })
    ({ pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        dotool
      ];
    })
  ];

  moduleNames = [
    "cli/ai"
    "cli/system/xilo.nix"
    "cli/music"

    "gui/linux-desktop/steamos.nix"
    "gui/network/clash-verge-rev.nix"
    "gui/games"

    "services/ime.nix"
  ];
}
