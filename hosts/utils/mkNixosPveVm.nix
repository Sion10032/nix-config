# vm:
# {
#   hostName = string;
#   disks = {
#     efi = { ... };
#     root = { uuid = string; fsType = string; };
#     home = { ... };
#     persist = { ... };
#   };
# }
vm: { lib, modulesPath, ... }:
{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  boot.initrd.availableKernelModules = [ "uhci_hcd" "ehci_pci" "ahci" "virtio_pci" "virtio_scsi" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems =
    {
      "/boot" = {
        device = "/dev/disk/by-uuid/${vm.disks.efi.uuid}";
        fsType = vm.disks.efi.fsType or "vfat";
        options = [ "fmask=0077" "dmask=0077" ];
      };

      "/" = {
        device = "/dev/disk/by-uuid/${vm.disks.root.uuid}";
        fsType = vm.disks.root.fsType or "xfs";
      };

      "/home" = {
        device = "/dev/disk/by-uuid/${vm.disks.home.uuid}";
        fsType = vm.disks.home.fsType or "xfs";
      };
    }
    // lib.optionalAttrs (builtins.hasAttr "persist" vm.disks) {
      "/persist" = {
        device = "/dev/disk/by-uuid/${vm.disks.persist.uuid}";
        fsType = vm.disks.persist.fsType or "xfs";
      };
    };

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;
  networking.hostName = vm.hostName;

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  services.qemuGuest.enable = true;

  services.printing.enable = false; # 禁用打印支持
  hardware.bluetooth.enable = false; # 禁用蓝牙支持

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?
}
