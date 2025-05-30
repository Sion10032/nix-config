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
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; inherit user; };
      system = "x86_64-linux";
      modules = commonModules ++ [
        ./users.nix
        ./hosts/nixos

        # Optionally, use home-manager.extraSpecialArgs to pass
        # arguments to home.nix
      ] ++ map (m: (import m user)) [
        ./modules/common/home-manager/user.nix
        ./modules/fonts.nix
        
        ./modules/common/cli/file
        
        ./modules/common/gui/browser
        ./modules/common/gui/media
        ./modules/common/gui/terminal
        
        ./modules/linux/gui/file

        # ./modules/linux/desktop/ly.nix
        ./modules/linux/desktop/regreet.nix
        ./modules/linux/desktop/i3
        ./modules/linux/desktop/hyprland
        ./modules/linux/desktop/xrdp.nix
      ];
    };
  };
}
