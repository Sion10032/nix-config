{ ... }: {
  home-manager.sharedModules = [
    ({ pkgs, lib, ... }: {
      programs.chromium = lib.mkIf pkgs.stdenv.isLinux {
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
