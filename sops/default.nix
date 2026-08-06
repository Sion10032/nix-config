{ ... }: {
  sops.defaultSopsFile = ./secrets/common.yaml;
  sops.age.sshKeyPaths = [];
  sops.age.keyFile = "/persist/private/age/key.txt";
  sops.age.generateKey = false;
}
