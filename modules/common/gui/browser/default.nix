{ sLib, ... }: {
  home-manager.sharedModules = [
    ({ pkgs, lib, ... }:
    {
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
    }
    // sLib.forLinux.attrs {
      programs.chromium = {
        enable = true;
        package = pkgs.ungoogled-chromium;
      };
    })
  ];
}
