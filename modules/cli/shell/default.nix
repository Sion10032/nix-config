{ ... }: {
  home-manager.sharedModules = [
    ({ ... }: {
      programs.zellij = {
        enable = true;
        # enableFishIntegration = true;
        settings = {
          pane_frames = false;
          default_shell = "fish";
        };
      };
    })
  ];
}
