{ sLib, ... }: {
  home-manager.sharedModules = [
    ({ pkgs, lib, ... }: {
      programs.bottom = {
        enable = true;
      };

      home.packages = with pkgs;
        [
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
