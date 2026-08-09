DEFAULT_SOPS_AGE_KEY_FILE := '/persist/private/age/key.txt'

alias d := deploy

deploy host=`hostname -s` *flags:
    nixos-rebuild switch --flake ~/nix-config#{{host}} --target-host root@{{host}} --show-trace {{flags}}

deploy-user host *flags:
    nixos-rebuild switch --flake ~/nix-config#{{host}} --target-host sion@{{host}} --show-trace --elevate=sudo --ask-elevate-password {{flags}}

debug:
    nix repl .

gc:
    sudo nix-collect-garbage -d

sops-edit key-file=DEFAULT_SOPS_AGE_KEY_FILE:
    cd ./sops && sudo SOPS_AGE_KEY_FILE={{key-file}} sops ./secrets/common.yaml

sops-update key-file=DEFAULT_SOPS_AGE_KEY_FILE:
    cd ./sops && sudo SOPS_AGE_KEY_FILE={{key-file}} sops updatekeys ./secrets/common.yaml

commit-msg:
    pi --no-session -p "Generate a git commit message. Output only the commit message, no explanation."

z:
    zellij a -c nix
