{ inputs, ... }: {
  imports = [
    inputs.nixos-hardware.nixosModules.asus-ally-rc71l
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot = {
    enable = true;
    edk2-uefi-shell.enable = true;
    extraFiles = {
      "EFI/systemd/drivers/UsbXbox360Dxe-x64.efi" = ./UsbXbox360Dxe-x64.efi;
    };
  };
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "ally";

  networking.networkmanager.enable = true;
  networking.wireless.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
  services.libinput.enable = true;

  system.stateVersion = "26.11";
}
