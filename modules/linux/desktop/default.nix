{ config, pkgs, ... }: {
  imports = [
    ./regreet.nix

    ./rofi
    ./dunst
    ./eww

    ./hyprland

    ./x.nix
    ./i3
  ];
}