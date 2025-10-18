{ ... }: {
  home-manager.sharedModules = [
    ({ ... }: {
      # programs.alacritty.enable = true;
      programs.kitty = {
        enable = true;
        shellIntegration.enableFishIntegration = true;
      };
    })
  ];
}
