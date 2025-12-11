{
  description = "Sion10032's NixOS flake";
  # How to inspect:
  # https://nixos-and-flakes.thiscute.world/zh/best-practices/debugging#%E9%80%9A%E8%BF%87-nix-repl-%E6%9F%A5%E7%9C%8B%E6%BA%90%E7%A0%81%E3%80%81%E8%B0%83%E8%AF%95%E9%85%8D%E7%BD%AE

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    vscode-server.url = "github:nix-community/nixos-vscode-server";
  };

  outputs = { self, nixpkgs, home-manager, nix-darwin, vscode-server, ... }@inputs: let
    commonModules = [
      ./nix-settings.nix
      ./modules/core.nix
      ./modules/common/env.nix
      ./modules/linux/network
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
  };
}
