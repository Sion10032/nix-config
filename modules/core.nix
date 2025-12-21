{ pkgs, lib, ... }: {
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    curl
    screen

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

    nil # Nix Language Server
  ];

  programs.fish.enable = true;
  # programs.nushell.enable = true;

  programs.git.enable = true;
  programs.lazygit.enable = true;
}
