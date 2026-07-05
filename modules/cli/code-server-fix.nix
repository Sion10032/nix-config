{ pkgs, ... }: {
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