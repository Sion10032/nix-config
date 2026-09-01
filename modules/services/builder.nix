{ sLib, ... }: {
  users.users.builder = {
    uid = 60000;
    createHome = false;
    home = "/var/empty";
    description = "Nix remote builder";

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK14fXDW8+X4JJKlj0i/h44bDltg0uSxiYDlLgeivu+v"
    ];
  }
  // sLib.forLinux.attrs {
    isNormalUser = true;
    hashedPassword = "!";
  };

  users.knownUsers = sLib.forDarwin.list [ "builder" ];
}
