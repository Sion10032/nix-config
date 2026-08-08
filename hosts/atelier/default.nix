{
  modules = [
    (import ../utils/mkNixosPveVm.nix {
      hostName = "atelier";
      disks = {
        efi.uuid = "FDA9-6E51";
        root.uuid = "d2e26f17-f215-4f50-a306-60ec97d88fb3";
        home.uuid = "d25e156c-ca98-4b90-bf5a-a88b639617d9";
      };
    })
    ({ ... }: {
      services.xrdp.defaultWindowManager = "xfce4-session";
    })
  ];

  moduleNames = [
    "services/builder.nix"
    "services/virtualization/docker.nix"
    "services/zed-remote-server.nix"
    "gui/linux-desktop/xfce4.nix"
    "gui/linux-desktop/xrdp.nix"

    # ./modules/gui/linux-desktop/kde.nix
    # (import ./modules/gui/linux-desktop/xrdp.nix "startplasma-x11")
  ];
}
