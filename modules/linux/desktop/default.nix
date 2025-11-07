{ config, pkgs, ... }: {
  imports = [
    ./regreet.nix

    ./rofi
    ./dunst
    ./eww
    ./ashell

    ./hyprland

    # ./x.nix
    # ./i3
  ];
}