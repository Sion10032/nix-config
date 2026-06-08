{ pkgs, lib, ... }: {
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
}
