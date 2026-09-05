{ inputs, config, lib, pkgs, modulesPath, ... }: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    inputs.nixos-hardware.nixosModules.microsoft-surface-pro-9
  ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "uas" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.kernelParams = [ "pci=hpiosize=0" ];
  boot.kernelPatches = [
    {
      name = "gpu-trim";
      patch = null;
      structuredExtraConfig = with pkgs.lib.kernel; {
        # AMD
        DRM_AMDGPU = no;
        DRM_RADEON = no;

        # NVIDIA
        DRM_NOUVEAU = no;
        DRM_NVIDIA = no;
      };
    }
    {
      name = "trim-unused-fs";
      patch = null;
      structuredExtraConfig = with pkgs.lib.kernel; {
        # embedded FS
        UBIFS_FS = no;
        JFFS2_FS = no;
        YAFFS_FS = no;

        # legacy FS
        REISERFS_FS = no;
        JFS_FS = no;
        HFS_FS = no;
        HFSPLUS_FS = no;
      };
    }
  ];
  
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/6a5ee359-8576-43d0-a0b5-231ff06c8e97";
    fsType = "btrfs";
    options = [ "subvol=@" ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/6a5ee359-8576-43d0-a0b5-231ff06c8e97";
    fsType = "btrfs";
    options = [ "subvol=@home" ];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/6a5ee359-8576-43d0-a0b5-231ff06c8e97";
    fsType = "btrfs";
    options = [ "subvol=@nix" ];
  };

  fileSystems."/persist" = {
    device = "/dev/disk/by-uuid/6a5ee359-8576-43d0-a0b5-231ff06c8e97";
    fsType = "btrfs";
    options = [ "subvol=@persist" ];
  };
  
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/93D9-ACD5";
    fsType = "vfat";
    options = [ "fmask=0022" "dmask=0022" ];
  };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
