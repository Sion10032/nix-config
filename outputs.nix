{
  self,
  nixpkgs,
  home-manager,
  nix-darwin,
  nix-homebrew,
  nixos-wsl,
  nixos-hardware,
  nixvim,
  zen-browser,
  vscode-server,
  ...
}@inputs: let
  lib = nixpkgs.lib;

  sLib = import ./lib;

  users = [ "sion" ];
  kanaFlakeRoot = ./.;

  homeModules = { ... }: {
    imports = [
      nixvim.homeModules.nixvim
      zen-browser.homeModules.beta
    ];
  };
  commonGuiModules = [
    ./modules/gui/core.nix

    ./modules/gui/fonts.nix

    ./modules/gui/browser
    ./modules/gui/editor
    ./modules/gui/file
    ./modules/gui/media
    ./modules/gui/terminal
  ];

  getCommonModules = system: [
    ./nix-settings.nix
    ./users.nix

    ./modules/core.nix
    ./modules/env.nix
    ./modules/git.nix

    ./modules/cli/ai
    ./modules/cli/file
    ./modules/cli/hardware
    ./modules/cli/shell
  ]
  ++ lib.optionals (lib.hasSuffix "linux" system) [
    vscode-server.nixosModules.default
    ./modules/cli/code-server-fix.nix
  
    home-manager.nixosModules.home-manager
  ]
  ++ lib.optionals (lib.hasSuffix "darwin" system) [
    nix-homebrew.darwinModules.nix-homebrew
    ./modules/homebrew.nix

    home-manager.darwinModules.home-manager
  ]
  ++ [
    ./modules/home-manager
    ./modules/home-manager/users.nix

    ({ ... }: {
      home-manager.sharedModules = [ homeModules ];
    })

    ./modules/cli/nixvim
  ];
  mkNixos = {
    system,
    modules,
    ...
  }@attrs:
  nixpkgs.lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs;
      inherit users;
      inherit kanaFlakeRoot;
    }
    // {
      sLib = (sLib { inherit system; inherit lib; });
    };
    modules = (getCommonModules system) ++ modules;
  };
  mkDarwin = {
    system,
    modules,
    ...
  }@attrs:
  nix-darwin.lib.darwinSystem {
    inherit system;
    specialArgs = {
      inherit inputs;
      inherit users;
      inherit kanaFlakeRoot;
    }
    // {
      sLib = (sLib { inherit system; inherit lib; });
    };
    modules = (getCommonModules system) ++ modules;
  };
in {
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
        ./modules/hardware.nix

        ./modules/linux-dektop
      ];
  };
  nixosConfigurations."nixos-vm-dev" = mkNixos {
    system = "x86_64-linux";
    modules =
      [
        (import ./hosts/nixos-pve-vm.nix {
          hostName = "nixos-vm-dev";
          disks = {
            efi.uuid = "FDA9-6E51";
            root.uuid = "d2e26f17-f215-4f50-a306-60ec97d88fb3";
            home.uuid = "d25e156c-ca98-4b90-bf5a-a88b639617d9";
          };
        })
      ]
      ++ commonGuiModules
      ++ [
        ./modules/cli/virtualization/podman.nix
      ] ++ [
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
        nixos-wsl.nixosModules.default
        {
          wsl = {
            enable = true;
            defaultUser = "sion";
          };
        }
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
      ++ commonGuiModules;
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
        nixos-hardware.nixosModules.microsoft-surface-pro-9
      ]
      ++ commonGuiModules
      ++ [
        ({ ... }: {
          services.desktopManager.gnome.enable = true;
          services.displayManager.gdm.enable = true;
        })
      ];
  };
}
