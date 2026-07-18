{ inputs, ... }: {
  home-manager.sharedModules = [
    ({ pkgs, ... }: {
      home.packages = [
       inputs.xilo.packages.${pkgs.system}.default
      ];
    })
  ];
}
