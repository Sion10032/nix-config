{ ... }: {
  home-manager.sharedModules = [
    ({ pkgs, lib, ... }: {
      programs.bottom = {
        enable = true;
      };

      home.packages = with pkgs;
        [
          bmon
        ] ++ lib.optionals pkgs.stdenv.isLinux [
          lm_sensors
        ] ++ lib.optionals pkgs.stdenv.isDarwin [
          macpm
        ];
    })
  ];
}