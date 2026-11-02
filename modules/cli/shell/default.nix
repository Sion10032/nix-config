{ ... }: {
  home-manager.sharedModules = [
    ({ ... }: {
      programs.zellij = {
        enable = true;
        # enableFishIntegration = true;
        settings = {
          pane_frames = false;
          default_shell = "fish";
          default_layout = "compact";
          plugins.compact-bar = {
            _props.location = "zellij:compact-bar";
            tooltip = "F1";
          };
        };
      };
    })
  ];
}
