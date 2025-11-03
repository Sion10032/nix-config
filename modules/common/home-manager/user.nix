user: { ... }: {
  home-manager.users.${user} = { pkgs, ... }: {
    home.username = user;
    # home.homeDirectory = "/home/${user}";

    targets.darwin.linkApps.enable = false;
    targets.darwin.copyApps = {
      enable = pkgs.stdenv.hostPlatform.isDarwin;
    };
  };
}
