{ sLib, pkgs, ... }: {
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    lazygit

    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    curl
    screen

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
// sLib.forLinux.attrs {
  # Run unpatched dynamic binaries on NixOS.
  programs.nix-ld.enable = true;

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocales = [
      "zh_CN.UTF-8/UTF-8"
    ];
  };
}
