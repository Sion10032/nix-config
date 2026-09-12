{ sLib, config, ... }: let
  createBuilder = attrs:
    attrs
    // {
      speedFactor = 10;
      protocol = "ssh-ng";

      publicHostKey = "c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSU4wTnBRaXdoakpBVmQ2TXdiSDRwcTZyS0hxL3FmSk9oOUlidXUvRG12K2g=";

      sshUser = "builder";
    }
    // sLib.forLinux.attrs {
      sshKey = "/persist/private/builder";
    }
    // sLib.forDarwin.attrs {
      sshKey = "/Volumes/persist/private/builder";
    };

  builders = [
    (createBuilder {
      hostName = "atelier";
      system = "x86_64-linux";
      systems = [
        "x86_64-linux"
        "i686-linux"
      ];
      supportedFeatures = [
        "kvm"
        "big-parallel"
      ];
    })
    (createBuilder {
      hostName = "ume";
      system = "aarch64-darwin";
      systems = [
        "aarch64-darwin"
      ];
      supportedFeatures = [
        "apple-virt"
        "big-parallel"
      ];
    })
  ];
in {
  nix.distributedBuilds = true;
  nix.buildMachines = builtins.filter
    (machine: machine.hostName != config.networking.hostName)
    builders;
}
