user: { ... }: {
  home-manager.users.${user} = { ... }: {
    # programs.alacritty.enable = true;
    programs.kitty = {
      enable = true;
      shellIntegration.enableFishIntegration = true;
    };
  };
}
