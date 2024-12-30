{
  description = "Sion10032's NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      system = "x86_64-linux";
      modules = [
        ./nix-settings.nix
        ./users.nix
        ./hosts/nixos

        # home-manager
        home-manager.nixosModules.home-manager
	./home-manager/core.nix
        ({ ... }: {
          home-manager.users = {
            sion = import ./home-manager/sion;
          };
          # Optionally, use home-manager.extraSpecialArgs to pass
          # arguments to home.nix
        })
      ];
    };
  };
}
