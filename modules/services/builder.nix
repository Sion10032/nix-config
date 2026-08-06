{ ... }: {
  users.users.builder = {
    isNormalUser = true;
    createHome = false;
    home = "/var/empty";
    hashedPassword = "!";
    description = "Nix remote builder";

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK14fXDW8+X4JJKlj0i/h44bDltg0uSxiYDlLgeivu+v"
    ];
  };
}
