{
  description = "Sion10032's NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: let
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
  };
}
