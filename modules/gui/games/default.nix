{ sLib, ... }: sLib.forLinux.attrs {
  home-manager.sharedModules = [
    ({ pkgs, ... }: {
      home.packages = with pkgs; [
        protonup-qt
      ];

      programs.lutris.enable = true;
    })
  ];
}