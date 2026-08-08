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

    "nexus" = {
      extraHostNames = [ "192.168.2.9" ];
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII5OuHhCLSUwDNxNSztfrB101ufFSqG7SoV6vDVEkvK9";
    };

    "atelier" = {
      extraHostNames = [ "192.168.2.12" ];
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN0NpQiwhjJAVd6MwbH4pq6rKHq/qfJOh9Ibuu/Dmv+h";
    };

    "akari" = {
      extraHostNames = [ "192.168.2.211" ];
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPzQdv8F0itOD5h1L97fMBCZI45es0RuEYz3cuAq9Ubk";
    };
    "ally" = {
      extraHostNames = [ "192.168.2.212" ];
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPBOtnZ+d5jSCaMdHqOgswoorRozi4E7NOSAjJZDG0d5";
    };
    "iris" = {
      extraHostNames = [ "192.168.2.213" ];
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPBOtnZ+d5jSCaMdHqOgswoorRozi4E7NOSAjJZDG0d5";
    };
  };

  programs.ssh.extraConfig = ''
    Host docker-on-debian
      HostName 192.168.2.3
      User sion

    Host ume
      HostName 192.168.2.4
      User sion

    Host nexus
      HostName 192.168.2.9
      User sion

    Host atelier
      HostName 192.168.2.12
      User sion

    Host akari
      HostName 192.168.2.211
      User sion

    Host ally
      HostName 192.168.2.212
      User sion

    Host iris
      HostName 192.168.2.213
      User sion
  '';

  services.openssh.hostKeys = [
    {
      path = "/persist/etc/ssh/ssh_host_ed25519_key";
      type = "ed25519";
    }
  ];
}
