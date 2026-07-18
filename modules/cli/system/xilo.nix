{ ... }: {
  home-manager.sharedModules = [
    ({ inputs, pkgs, ... }: {
      home.packages = [
       inputs.xilo.packages.${pkgs.system}.default
      ];
    })
  ];
}
