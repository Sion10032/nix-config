user: { ... }: {
  home-manager.users.${user} = { config, pkgs, ... }@inputs: {
    programs.eww = {
      enable = true;
    };
  };
}