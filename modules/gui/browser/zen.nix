{ inputs, ... }: {
  home-manager.sharedModules = [
    ({ config, ... }: {
      imports = [
        inputs.zen-browser.homeModules.beta
      ];

      programs.zen-browser = {
        enable = true;
        languagePacks = [ "zh-CN" "en-US" ];

        policies = {
          DisableAppUpdate = true;
          DisableFeedbackCommands = true;
          DisableFirefoxStudies = true;
          DisablePocket = true;
          DisableTelemetry = true;
          DontCheckDefaultBrowser = true;
          NoDefaultBookmarks = true;
          OfferToSaveLogins = false;
        };

        profilesPath = "${config.xdg.dataHome}/zen-browser";
        # profiles."sion" = {
        #   id = 0;
        #   name = "sion";
        #   path = "sion";
        # };
      };
    })
  ];
}
