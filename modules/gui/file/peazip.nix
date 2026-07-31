{ sLib, ... }: sLib.forLinux.attrs {
  home-manager.sharedModules = [
    ({ pkgs, ... }: {
      home.packages = with pkgs; [
        peazip
      ];
    })
  ];
}
