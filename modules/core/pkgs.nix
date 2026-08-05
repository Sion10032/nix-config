{ sLib, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    git
    lazygit

    wget
    curl
    screen

    vim
    nano
    fresh-editor

    # net tools
    bind

    # system monitor
    htop

    # archiver
    zip
    unzip
    unar
    p7zip

    fastfetch

    just

    # Nix Language Server
    nixd
    nil
  ] ++ sLib.forLinux.list [
    net-tools
  ];

  programs.fish.enable = true;

  home-manager.sharedModules = [
    ({ ... }: {
      programs.fish.enable = true;
    })
  ];
}
