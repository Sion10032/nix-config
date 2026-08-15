{ sLib, ... }: {
  sops.defaultSopsFile = ./secrets/common.yaml;
  sops.age.sshKeyPaths = [];
  sops.age.generateKey = false;
  sops.age.keyFile = sLib.firstNonEmptyString [
    (sLib.forLinux.string "/persist/private/age/key.txt")
    (sLib.forDarwin.string "/Volumes/persist/private/age/key.txt")
  ];
}