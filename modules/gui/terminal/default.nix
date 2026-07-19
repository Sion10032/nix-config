{ ... }: {
  home-manager.sharedModules = [
    ({ ... }: {
      programs.rio = {
        enable = true;
        # https://rioterm.com/docs/config
        settings = {
          confirm-before-quit = false;
          fonts = {
            size = 16;
            family = "Maple Mono Normal NF CN";
          };
        };
      };
    })
  ];
}
