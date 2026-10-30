{
  gui = [ "core" "basic" ];

  modules = [
    (import ../utils/mkNixosPveVm.nix {
      hostName = "island";
      disks = {
        efi.uuid = "ABE2-6B09";
        root.uuid = "18378538-85c2-4f14-8dab-73fb8a9fd1f8";
        home.uuid = "46ab202f-6e7d-4cb0-917d-8e53bc454ab3";
        persist.uuid = "8e8a35c1-0d8e-4015-b017-9836105b7fd2";
      };
    })
    ({ ... }: {
      security.sops.enable = false;
    })
    ({ ... }: {
      home-manager.sharedModules = [
        ({ pkgs, ... }: {
          home.packages = with pkgs; [
            qq
            wechat-uos
          ];
        })
      ];
    })
    ({ ... }: {
      services.xrdp.defaultWindowManager = "dbus-run-session xfce4-session";
    })
    ({ inputs, ... }: {
      imports = [ inputs.kasmvnc.nixosModules.default ];
      services.kasmvnc = {
        enable = true;
        user = "sion";
        # passwordFile = "/run/secrets/kasmvnc-password";
        windowManager = "dbus-run-session xfce4-session";
        openFirewall = true;
      };
    })
  ];

  moduleNames = [
    "gui/linux-desktop/xfce4.nix"
    "gui/linux-desktop/xrdp.nix"

    # "services/zed-remote-server.nix"
    "services/ime.nix"
    # ./modules/gui/linux-desktop/kde.nix
    # (import ./modules/gui/linux-desktop/xrdp.nix "startplasma-x11")
  ];
}
