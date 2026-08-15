{ ... }: {
  imports = [
    ./pkgs.nix
    ./git.nix
    ./env.nix
    ./ssh.nix

    ./buildMachines.nix

    ./linux.nix
  ];

  time.timeZone = "Asia/Shanghai";
  services.openssh.enable = true;
}
