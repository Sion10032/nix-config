{ sLib, ... }:
(sLib.forLinux.attrs {
  home-manager.sharedModules = [
    ({ pkgs, ... }: {
      programs.chromium = {
        enable = true;
        package = pkgs.ungoogled-chromium;
      };
    })
  ];
})
// (sLib.forDarwin.attrs {
  homebrew.casks = [
    "ungoogled-chromium"
  ];
})
