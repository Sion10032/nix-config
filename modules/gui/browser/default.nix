{ sLib, ... }: {
  imports = [
    ./zen-browser.nix
  ];

  home-manager.sharedModules = sLib.forLinux.list [
    ({ pkgs, ... }: {
      programs.chromium = {
        enable = true;
        package = pkgs.ungoogled-chromium;
      };
    })
  ];
}
