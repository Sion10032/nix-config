{ sLib, lib, config, ... }: let
  cfg = config.security.sops;
in {
  options = {
    security.sops = {
      enable = lib.mkOption {
        default = true;
        example = true;
        description = "Whether to enable sops-nix.";
        type = lib.types.bool;
      };
      secrets = lib.mkOption {
        type = lib.types.submodule {
          freeformType = with lib.types; attrsOf anything;
        };
        default = {};
      };
    };
  };

  config = lib.mkIf cfg.enable {
    sops.defaultSopsFile = ./secrets/common.yaml;
    sops.age.sshKeyPaths = [];
    sops.age.generateKey = false;
    sops.age.keyFile = sLib.firstNonEmptyString [
      (sLib.forLinux.string "/persist/private/age/key.txt")
      (sLib.forDarwin.string "/Volumes/persist/private/age/key.txt")
    ];

    sops.secrets = cfg.secrets;
  };
}