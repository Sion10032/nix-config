{ ... }: {
  programs.ssh.knownHosts = {
    "github.com" = {
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";
    };

    "docker-on-debian" = {
      extraHostNames = [ "192.168.2.3" ];
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPPSl8+e5MmMncrCJrqcQ100Vsvi3df/RISy6XnobR6b";
    };

    "nixos-vm-dev" = {
      extraHostNames = [ "192.168.2.12" ];
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN0NpQiwhjJAVd6MwbH4pq6rKHq/qfJOh9Ibuu/Dmv+h";
    };

    # "akari".publicKey = "";
    # "ally".publicKey = "";

    "ume" = {
      extraHostNames = [ "192.168.2.4" ];
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFFOWLX9G5MP5V7RBYxkaz+Itb7iCkbzu+Nap3z3Y6VM";
    };
    # "iris".publicKey = "";
  };

  home-manager.sharedModules = [
    ({ ... }: {
      programs.ssh = {
        enable = true;
        enableDefaultConfig = false;
        settings = {
          "docker-on-debian" = {
            HostName = "192.168.2.3";
            User = "sion";
          };

          "nixos-vm-dev" = {
            HostName = "192.168.2.12";
            User = "sion";
          };

          # "akari" = {
          #   HostName = "";
          #   User = "sion";
          # };
          # "ally" = {
          #   HostName = "";
          #   User = "sion";
          # };

          "ume" = {
            HostName = "192.168.2.4";
            User = "sion";
          };
          # "iris" = {
          #   HostName = "";
          #   User = "sion";
          # };
        };
      };
    })
  ];
}
