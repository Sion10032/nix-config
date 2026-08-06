{ ... }: {
  programs.ssh.knownHosts = {
    "github.com" = {
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";
    };

    "docker-on-debian" = {
      extraHostNames = [ "192.168.2.3" ];
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPPSl8+e5MmMncrCJrqcQ100Vsvi3df/RISy6XnobR6b";
    };

    "ume" = {
      extraHostNames = [ "192.168.2.4" ];
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFFOWLX9G5MP5V7RBYxkaz+Itb7iCkbzu+Nap3z3Y6VM";
    };

    "atelier" = {
      extraHostNames = [ "192.168.2.12" ];
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN0NpQiwhjJAVd6MwbH4pq6rKHq/qfJOh9Ibuu/Dmv+h";
    };

    # "akari".publicKey = "";
    # "ally".publicKey = "";
    # "iris".publicKey = "";
  };

  programs.ssh.extraConfig = ''
    Host docker-on-debian
      HostName 192.168.2.3
      User sion

    Host ume
      HostName 192.168.2.4
      User sion

    Host atelier
      HostName 192.168.2.12
      User sion

    # Host akari
    #   HostName
    #   User sion

    # Host ally
    #   HostName
    #   User sion

    # Host iris
    #   HostName
    #   User sion
  '';
}
