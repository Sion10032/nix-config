user: { ... }: {
  home-manager.users.${user} = { config, pkgs, ... }@inputs: {
    services.dunst = {
      enable = true;
    };
  };
}