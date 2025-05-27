{ pkgs, ... }: {
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    curl
    screen

    git

    # shell
    fish
    # nushell

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
    # termscp
  ];

  # Run unpatched dynamic binaries on NixOS.
  programs.nix-ld.enable = true;

  programs.fish.enable = true;
  # programs.nushell.enable = true;
}
