{ self, nixpkgs, home-manager, nix-darwin, nixos-wsl, vscode-server, ... }@inputs: let
  commonModules = [
    ./nix-settings.nix
    ./modules/core.nix
    ./modules/common/env.nix
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
        ./hosts/nixos-vm
        ./modules/linux/core.nix
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
        ./hosts/nixos-vm-dev
        ./modules/linux/core.nix
      ]
      ++ [
        ./modules/fonts.nix

        ./modules/common/cli/docker
        ./modules/common/cli/file
        ./modules/common/cli/hardware

        ./modules/common/cli/ai

        vscode-server.nixosModules.default
        ({ config, pkgs, ... }: {
          services.vscode-server = {
            enable = true;
            enableFHS = true;
            extraRuntimeDependencies = with pkgs; [
              icu
              # libgcc
            ];
          };
        })
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

        ./modules/common/cli/file
        ./modules/common/cli/hardware
      ];
  };
}
