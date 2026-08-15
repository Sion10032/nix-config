{ sLib, ... }: {
  home-manager.sharedModules = [
    ({ ... }: {
      # programs.rio = {
      #   enable = true;
      #   # https://rioterm.com/docs/config
      #   settings = {
      #     confirm-before-quit = false;
      #     fonts = {
      #       size = 16;
      #       family = "Maple Mono Normal NF CN";
      #     };
      #   };
      # };

      programs.kitty = {
        enable = true;

        font = {
          size = sLib.firstNonZero [
            (sLib.forLinux.number 12)
            (sLib.forDarwin.number 16)
            14 # fallback default value
          ];
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
