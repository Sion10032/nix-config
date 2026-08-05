{ ... }: {
  imports = [
    ./pkgs.nix
    ./git.nix
    ./env.nix
    ./ssh.nix

    ./linux.nix
  ];
}
