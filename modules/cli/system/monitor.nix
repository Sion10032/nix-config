{ sLib, ... }: {
  home-manager.sharedModules = [
    ({ pkgs, ... }: {
      programs.bottom = {
        enable = true;
      };

      home.packages = with pkgs;
        [
          btop
          bmon
          smartmontools
        ] ++ sLib.forLinux.list [
          lm_sensors
        ] ++ sLib.forDarwin.list [
          macpm
        ];
    })
  ];
}
