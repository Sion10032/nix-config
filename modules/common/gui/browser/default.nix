{ ... }: {
  home-manager.sharedModules = [
    ({ pkgs, ... }: {
      programs.chromium = {
        enable = true;
        package = pkgs.ungoogled-chromium;
      };

      programs.librewolf = {
        enable = true;
        languagePacks = [ "zh-CN" "en-US" ];
      };
    })
  ];
}
