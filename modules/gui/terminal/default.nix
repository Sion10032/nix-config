user: { ... }: {
  home-manager.users.${user} = { ... }: {
    programs.kitty = {
      enable = true;
      shellIntegration.enableFishIntegration = true;
    };
  };
}
