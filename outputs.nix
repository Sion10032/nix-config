{ self, nixpkgs, home-manager, nix-darwin, nixos-wsl, vscode-server, ... }@inputs: let
  commonModules = [
    ./nix-settings.nix
    ./modules/core.nix
    ./modules/common/env.nix
    ./modules/common/git.nix
    ./modules/common/cli/shell
    ./users.nix
  ];
  nixosHomeManagerModules = [
    home-manager.nixosModules.home-manager
    ./modules/common/home-manager
    ./modules/common/home-manager/users.nix
  ];
  darwinHomeManagerModules = [
    home-manager.darwinModules.home-manager
    ./modules/common/home-manager
    ./modules/common/home-manager/users.nix
  ];
  users = [ "sion" ];
  defaultApps = {

  };
  kanaFlakeRoot = ./.;
in {
  nixosConfigurations."nixos-vm" = nixpkgs.lib.nixosSystem {
    # Optionally, use home-manager.extraSpecialArgs to pass
    # arguments to home.nix
    specialArgs = {
      inherit inputs;
      inherit users;
      inherit kanaFlakeRoot;
    };
    system = "x86_64-linux";
    modules = 
      commonModules 
      ++ nixosHomeManagerModules 
      ++ [
        (import ./hosts/nixos-pve-vm.nix {
          hostName = "nixos-vm";
          disks = {
            efi.uuid = "123C-A103";
            root.uuid = "d391dd2e-579a-4768-aa1e-effd0d49e671";
            home.uuid = "a9c67982-104b-4f67-9152-9779f3fb45d8";
          };
        })
        ./modules/linux/core.nix
        ./modules/linux/gui/core.nix
      ]
      ++ [
        ./modules/fonts.nix

        ./modules/common/cli/file
        ./modules/common/cli/hardware

        ./modules/common/gui/browser
        ./modules/common/gui/dev
        ./modules/common/gui/file
        ./modules/common/gui/media
        ./modules/common/gui/terminal

        ./modules/linux/hardware
        ./modules/linux/desktop

        ./modules/linux/gui/file
      ];
  };
  nixosConfigurations."nixos-vm-dev" = nixpkgs.lib.nixosSystem {
    # Optionally, use home-manager.extraSpecialArgs to pass
    # arguments to home.nix
    specialArgs = {
      inherit inputs;
      inherit users;
      inherit kanaFlakeRoot;
    };
    system = "x86_64-linux";
    modules =
      commonModules
      ++ nixosHomeManagerModules
      ++ [
        (import ./hosts/nixos-pve-vm.nix {
          hostName = "nixos-vm-dev";
          disks = {
            efi.uuid = "FDA9-6E51";
            root.uuid = "d2e26f17-f215-4f50-a306-60ec97d88fb3";
            home.uuid = "d25e156c-ca98-4b90-bf5a-a88b639617d9";
          };
        })
        ./modules/linux/core.nix
        ./modules/linux/gui/core.nix
      ]
      ++ [
        ./modules/fonts.nix

        ./modules/common/cli/docker
        ./modules/common/cli/file
        ./modules/common/cli/hardware

        ./modules/common/cli/ai/coding.nix

        vscode-server.nixosModules.default
        ({ config, pkgs, ... }: {
          services.vscode-server = {
            enable = true;
            enableFHS = true;
            nodejsPackage = pkgs.nodejs_22;
            extraRuntimeDependencies = with pkgs; [
              icu
              # libgcc
            ];
          };
        })
      ] ++ [
        ./modules/linux/desktop/xfce4.nix
        (import ./modules/linux/desktop/xrdp.nix "xfce4-session")

        # ./modules/linux/desktop/kde.nix
        # (import ./modules/linux/desktop/xrdp.nix "startplasma-x11")
      ];
  };
  nixosConfigurations."nixos-wsl" = nixpkgs.lib.nixosSystem {
    # Optionally, use home-manager.extraSpecialArgs to pass
    # arguments to home.nix
    specialArgs = {
      inherit inputs;
      inherit users;
      inherit kanaFlakeRoot;
    };
    system = "x86_64-linux";
    modules =
      commonModules
      ++ nixosHomeManagerModules
      ++ [
        nixos-wsl.nixosModules.default
        {
          wsl = {
            enable = true;
            defaultUser = "sion";
          };
        }
        ./hosts/nixos-wsl
        ./modules/linux/core.nix
      ]
      ++ [
        ./modules/fonts.nix
        ./modules/common/cli/file
        ./modules/common/cli/media
      ];
  };
  darwinConfigurations."iris" = nix-darwin.lib.darwinSystem {
    specialArgs = { inherit inputs; inherit users; };
    modules = 
      commonModules
      ++ darwinHomeManagerModules
      ++ [ 
        ./hosts/iris
      ]
      ++ [
        ./modules/fonts.nix

        ./modules/common/cli/file
        ./modules/common/cli/hardware

        ./modules/common/gui/browser
        ./modules/common/gui/dev
        ./modules/common/gui/media
        ./modules/common/gui/terminal
      ];
  };
  darwinConfigurations."ume" = nix-darwin.lib.darwinSystem {
    specialArgs = { inherit inputs; inherit users; };
    modules = 
      commonModules
      ++ darwinHomeManagerModules
      ++ [ 
        ./hosts/ume
      ]
      ++ [
        ./modules/fonts.nix

        ./modules/common/cli/ai/coding.nix

        ./modules/common/cli/file
        ./modules/common/cli/hardware
      ];
  };
}
