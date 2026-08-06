{ ... }: {
  nix.buildMachines = [
    {
      hostName = "atelier";
      system = "x86_64-linux";
      systems = [
        "x86_64-linux"
      ];
      supportedFeatures = [
        "kvm"
        "big-parallel"
      ];
      speedFactor = 1;
      protocol = "ssh-ng";

      publicHostKey = "c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSU4wTnBRaXdoakpBVmQ2TXdiSDRwcTZyS0hxL3FmSk9oOUlidXUvRG12K2g=";

      sshUser = "builder";
      sshKey = "/persist/private/builder";
    }
  ];
}
