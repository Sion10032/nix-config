{
  description = "Sion10032's NixOS flake";

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
  };

  outputs = { self, nixpkgs, home-manager, nix-darwin, ... }@inputs: let
    commonModules = [
      ./nix-settings.nix
      ./modules/core.nix

      # home-manager
      home-manager.nixosModules.home-manager
      ./modules/common/home-manager
    ];
    user = "sion";
  in {
    nixosConfigurations."nixos-vm" = nixpkgs.lib.nixosSystem {
      # Optionally, use home-manager.extraSpecialArgs to pass
      # arguments to home.nix
      specialArgs = { inherit inputs; inherit user; };
      system = "x86_64-linux";
      modules = commonModules ++ [
        ./hosts/nixos-vm
        ./users.nix

        ./modules/linux/core.nix
      ] ++ [
        ./modules/fonts.nix
        ./modules/common/cli/file

        ./modules/common/gui/browser
        ./modules/common/gui/dev
        ./modules/common/gui/file
        ./modules/common/gui/media
        ./modules/common/gui/terminal

        ./modules/linux/hardware
        ./modules/linux/desktop

        ./modules/linux/gui/file
      ] ++ [
        (import ./modules/common/home-manager/user.nix user)
      ];
    };
    darwinConfigurations."iris" = nix-darwin.lib.darwinSystem {
      specialArgs = { inherit inputs; inherit user; };
      modules = commonModules ++ [ 
        ./hosts/iris
        ./users.nix

        ./modules/common/cli/file

        ./modules/common/gui/media
        ./modules/common/gui/terminal
      ] ++ [
        (import ./modules/common/home-manager/user.nix user)
      ];
    };
  };
}
