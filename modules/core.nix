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
    btop

    # archiver
    zip
    unzip
    unar
    p7zip

    # file manager
    nnn

    fastfetch

    just

    # Nix Language Server
    nixd
    nil

    # shell
    fish
    nushell
  ];

  home-manager.sharedModules = [
    ({ ... }: {
      programs.fish.enable = true;
      programs.nushell.enable = true;
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
