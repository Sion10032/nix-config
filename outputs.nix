{
  self,
  nixpkgs,
  nix-darwin,
  home-manager,
  sops-nix,
  ...
}@inputs: let
  lib = nixpkgs.lib;

  sLib = import ./lib;

  users = [ "sion" ];

  commonGuiModules = [
    ./modules/gui/core.nix

    ./modules/gui/fonts.nix

    ./modules/gui/browser
    ./modules/gui/editor
    ./modules/gui/file/peazip.nix
    ./modules/gui/file/motrix-next.nix
    ./modules/gui/media
    ./modules/gui/network/freerdp.nix
    ./modules/gui/terminal
  ];

  getCommonModules = system: [
    ./nix-settings.nix
    ./users.nix
    ./sops

    ./modules/core

    ./modules/cli/ai
    ./modules/cli/file
    ./modules/cli/security
    ./modules/cli/shell
    ./modules/cli/system/monitor.nix
  ] ++ lib.optionals (lib.hasSuffix "linux" system) [
    ./modules/services/vscode-server.nix
    sops-nix.nixosModules.sops
    home-manager.nixosModules.home-manager
  ] ++ lib.optionals (lib.hasSuffix "darwin" system) [
    ./modules/homebrew.nix
    sops-nix.darwinModules.sops
    home-manager.darwinModules.home-manager
  ] ++ [
    ./modules/home-manager
    ./modules/home-manager/users.nix

    ./modules/cli/nixvim
  ] ++ [
    ({ ... }: {
      nixpkgs.overlays = [
        self.overlays.default
      ];
    })
  ];
  mkNixos = {
    system ? "x86_64-linux",
    modules,
    specialArgs ? {},
    ...
  }@attrs:
  nixpkgs.lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs;
      inherit users;
    }
    // specialArgs
    // {
      sLib = (sLib { inherit system; inherit lib; });
    };
    modules = (getCommonModules system) ++ modules;
  } // (removeAttrs attrs [ "system" "modules" "specialArgs" ]);
  mkDarwin = {
    system,
    modules,
    specialArgs ? {},
    ...
  }@attrs:
  nix-darwin.lib.darwinSystem {
    inherit system;
    specialArgs = {
      inherit inputs;
      inherit users;
    }
    // specialArgs
    // {
      sLib = (sLib { inherit system; inherit lib; });
    };
    modules = (getCommonModules system) ++ modules;
  } // (removeAttrs attrs [ "system" "modules" "specialArgs" ]);
in {
  overlays.default = import ./overlay.nix;

  nixosConfigurations."atelier" = mkNixos {
    modules =
      [
        (import ./hosts/nixos-pve-vm.nix {
          hostName = "atelier";
          disks = {
            efi.uuid = "FDA9-6E51";
            root.uuid = "d2e26f17-f215-4f50-a306-60ec97d88fb3";
            home.uuid = "d25e156c-ca98-4b90-bf5a-a88b639617d9";
          };
        })
      ]
      ++ commonGuiModules
      ++ [
        ./modules/services/builder.nix
        ./modules/services/virtualization/docker.nix
        ./modules/services/zed-remote-server.nix
      ]
      ++ [
        ./modules/gui/linux-desktop/xfce4.nix
        (import ./modules/gui/linux-desktop/xrdp.nix "xfce4-session")

        # ./modules/gui/linux-desktop/kde.nix
        # (import ./modules/gui/linux-desktop/xrdp.nix "startplasma-x11")
      ];
  };
  darwinConfigurations."iris" = mkDarwin {
    system = "aarch64-darwin";
    modules =
      [
        ./hosts/iris
      ]
      ++ commonGuiModules
      ++ [
        ./modules/gui/system
        ./modules/gui/network/clash-verge-rev.nix
      ];
  };
  darwinConfigurations."ume" = mkDarwin {
    system = "aarch64-darwin";
    modules =
      [
        ./hosts/ume
        ./modules/cli/virtualization/lima.nix
      ];
  };
  nixosConfigurations."akari" = mkNixos {
    modules =
      [
        ./hosts/akari
      ]
      ++ commonGuiModules
      ++ [
        ({ ... }: {
          services.desktopManager.gnome.enable = true;
          services.displayManager.gdm.enable = true;
        })
      ];
  };
  nixosConfigurations."ally" = mkNixos {
    modules =
      [
        ./hosts/ally

        ./modules/cli/system/xilo.nix
        ./modules/cli/music
      ]
      ++ commonGuiModules
      ++ [
        ./modules/gui/linux-desktop/steamos.nix

        ./modules/services/ime.nix

        ./modules/gui/network/clash-verge-rev.nix
        ./modules/gui/games
      ];
  };

  nixosConfigurations."nixos-vm" = mkNixos {
    modules =
      [
        (import ./hosts/nixos-pve-vm.nix {
          hostName = "nixos-vm";
          disks = {
            efi.uuid = "123C-A103";
            root.uuid = "d391dd2e-579a-4768-aa1e-effd0d49e671";
            home.uuid = "a9c67982-104b-4f67-9152-9779f3fb45d8";
          };
        })
      ]
      ++ commonGuiModules
      ++ [
        # ./modules/hardware.nix
        # ./modules/linux-dektop
      ];
  };
  nixosConfigurations."nixos-wsl" = mkNixos {
    modules =
      [
        ./hosts/nixos-wsl
        ./modules/cli/media
      ];
  };
}
