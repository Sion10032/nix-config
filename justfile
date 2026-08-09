DEFAULT_SOPS_AGE_KEY_FILE := '/persist/private/age/key.txt'

d host=`hostname -s` *flags:
    nixos-rebuild switch --flake ~/nix-config#{{host}} --target-host root@{{host}} --show-trace {{flags}}

debug:
    nix repl .

gc:
    sudo nix-collect-garbage -d

sops-edit key-file=DEFAULT_SOPS_AGE_KEY_FILE:
    cd ./sops && sudo SOPS_AGE_KEY_FILE={{key-file}} sops ./secrets/common.yaml

sops-update key-file=DEFAULT_SOPS_AGE_KEY_FILE:
    cd ./sops && sudo SOPS_AGE_KEY_FILE={{key-file}} sops updatekeys ./secrets/common.yaml

z:
    zellij a -c nix
