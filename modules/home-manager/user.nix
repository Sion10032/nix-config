user: { ... }: {
  home-manager.users.${user} = { ... }: {
    home.username = user;
    home.homeDirectory = "/home/${user}";
  };
}
