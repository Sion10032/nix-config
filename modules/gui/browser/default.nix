user: { ... }: {
  home-manager.users.${user} = { pkgs, ... }: {
    programs.chromium = {
      enable = true;
      package = pkgs.ungoogled-chromium;
    };

    programs.floorp = {
      enable = true;
      languagePacks = [ "zh-CN" "en-US" ];
    };
  };
}
