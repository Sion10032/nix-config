{
  self,
  nixpkgs,
  nix-darwin,
  home-manager,
  sops-nix,
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
    ./sops

    ./modules/core

    ./modules/cli/file
    ./modules/cli/security
    ./modules/cli/shell
    ./modules/cli/system/monitor.nix
  ] ++ lib.optionals (lib.hasSuffix "linux" system) [
    ./modules/services/vscode-server.nix
    sops-nix.nixosModules.sops
    home-manager.nixosModules.home-manager
  ] ++ lib.optionals (lib.hasSuffix "darwin" system) [
    ./modules/homebrew.nix
    sops-nix.darwinModules.sops
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
  mkSystem = builder: {
    system,
    modules ? [],
    specialArgs ? {},
    gui ? false,
    moduleNames? [],
    ...
  }@attrs:
  builder {
    inherit system;
    specialArgs =
      { inherit inputs users; }
      // specialArgs
      // { sLib = (sLib { inherit system; inherit lib; }); };
    modules =
      (getCommonModules system)
      ++ modules
      ++ lib.optionals gui commonGuiModules
      ++ lib.map (name: ./modules/${name}) moduleNames;
  } // (removeAttrs attrs [ "system" "modules" "specialArgs" "gui" "moduleNames" ]);

  mkNixos = path: mkSystem nixpkgs.lib.nixosSystem ({ system = "x86_64-linux"; } // import path);
  mkDarwin = path: mkSystem nix-darwin.lib.darwinSystem ({ system = "aarch64-darwin"; } // import path);
in {
  overlays.default = import ./overlay.nix;

  nixosConfigurations."atelier"   = mkNixos ./hosts/atelier;
  nixosConfigurations."akari"     = mkNixos ./hosts/akari;
  nixosConfigurations."ally"      = mkNixos ./hosts/ally;
  nixosConfigurations."mitou"     = mkNixos ./hosts/mitou;
  nixosConfigurations."nexus"     = mkNixos ./hosts/nexus;
  nixosConfigurations."nixos-wsl" = mkNixos ./hosts/nixos-wsl;

  darwinConfigurations."ume"      = mkDarwin ./hosts/ume;
  darwinConfigurations."iris"     = mkDarwin ./hosts/iris;
}
