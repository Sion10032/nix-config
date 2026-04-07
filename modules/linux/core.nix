{ pkgs, ... }: {
  # Run unpatched dynamic binaries on NixOS.
  programs.nix-ld.enable = true;
  
  environment.systemPackages = with pkgs; [
    mesa
  ];
}