{
  modules = [
    ({ inputs, ... }: {
      imports = [
        inputs.nixos-wsl.nixosModules.default
      ];
      wsl = {
        enable = true;
        defaultUser = "sion";
      };

      networking.hostName = "nixos-wsl";

      system.stateVersion = "25.11";
    })
  ];

  moduleNames = [
    "cli/media"
  ];
}
