{ inputs, pkgs, sLib, ... }: sLib.forLinux.attrs {
  imports = [
    inputs.vscode-server.nixosModules.default
  ];

  services.vscode-server = {
    enable = true;
    enableFHS = true;
    nodejsPackage = pkgs.nodejs_22;
    extraRuntimeDependencies = with pkgs; [
      icu
      # libgcc
    ];
  };
}