{
  self,
  nixpkgs,
  home-manager,
  nix-darwin,
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

    ./modules/core

    ./modules/cli/ai
    ./modules/cli/file
    ./modules/cli/shell
    ./modules/cli/system/monitor.nix
  ] ++ lib.optionals (lib.hasSuffix "linux" system) [
    ./modules/services/vscode-server.nix

    home-manager.nixosModules.home-manager
  ] ++ lib.optionals (lib.hasSuffix "darwin" system) [
    ./modules/homebrew.nix

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
    system,
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

  nixosConfigurations."nixos-vm" = mkNixos {
    system = "x86_64-linux";
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
  nixosConfigurations."atelier" = mkNixos {
    system = "x86_64-linux";
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
  nixosConfigurations."nixos-wsl" = mkNixos {
    system = "x86_64-linux";
    modules =
      [
        ./hosts/nixos-wsl
      ]
      ++ [
        ./modules/cli/media
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
      ]
      ++ [
        ./modules/cli/virtualization/lima.nix

        # ({ ... }: {
        #   launchd.daemons.nix-daemon.serviceConfig.EnvironmentVariables = {
        #     HTTP_PROXY  = "http://192.168.2.251:8192";
        #     HTTPS_PROXY = "http://192.168.2.251:8192";
        #     ALL_PROXY   = "http://192.168.2.251:8192";
        #   };
        # })
      ];
  };
  nixosConfigurations."akari" = mkNixos {
    system = "x86_64-linux";
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
    system = "x86_64-linux";
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
}
