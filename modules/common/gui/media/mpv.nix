user: { ... }: {
  home-manager.users.${user} = { ... }: {
    programs.mpv = {
      enable = true;
    };
  };
}
