{ ... }: {
  home-manager.sharedModules = [
    ({ pkgs, lib, ... }: {
      programs.bottom = {
        enable = true;
      };

      home.packages = with pkgs;
        [
        ] ++ lib.optionals pkgs.stdenv.isDarwin [
          macpm
        ];
    })
  ];
}