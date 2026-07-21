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

      programs.kitty = {
        enable = true;

        font = {
          size = 12;
          name = "Maple Mono Normal NF CN";
        };

        shellIntegration = {
          enableFishIntegration = true;
          enableBashIntegration = true;
        };
      };
    })
  ];
}
