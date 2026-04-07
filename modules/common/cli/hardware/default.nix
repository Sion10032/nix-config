{ ... }: {
  home-manager.sharedModules = [
    ({ pkgs, lib, ... }: {
      programs.bottom = {
        enable = true;
      };

      home.packages = with pkgs;
        [
          lm_sensors
        ] ++ lib.optionals pkgs.stdenv.isDarwin [
          macpm
        ];
    })
  ];
}