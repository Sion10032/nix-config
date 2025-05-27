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
      ./modules/home-manager
    ];
    user = "sion";
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; inherit user; };
      system = "x86_64-linux";
      modules = commonModules ++ [
        ./users.nix
        ./hosts/nixos

        # Optionally, use home-manager.extraSpecialArgs to pass
        # arguments to home.nix
      ] ++ map (m: (import m user)) [
        ./modules/home-manager/user.nix
        ./modules/fonts.nix
        
        ./modules/cli/file
        
        ./modules/gui/browser
        ./modules/gui/file
        ./modules/gui/media
        ./modules/gui/terminal

        ./modules/desktop/ly.nix
        ./modules/desktop/i3
      ];
    };
  };
}
