{ inputs, ... }: {
  home-manager.sharedModules = [
    ({ pkgs, lib, ... }: {
      imports = [
        inputs.zen-browser.homeModules.beta
      ];

      programs.chromium = lib.mkIf pkgs.stdenv.isLinux {
        enable = true;
        package = pkgs.ungoogled-chromium;
      };

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
      };
    })
  ];
}
