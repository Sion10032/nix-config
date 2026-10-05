{ ... }: {
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      # "https://mirror.nju.edu.cn/nix-channels/store"
      # "https://mirror.sjtu.edu.cn/nix-channels/store"
      "https://nix-community.cachix.org"
      "https://cache.nixos.org/"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];

    extra-substituters = [
      "https://xilo.i.kanakana.moe/c/sion/pkgs"
    ];
    extra-trusted-public-keys = [
      "pkgs:mgg3hmcRKfyp8AWvDg0yBP/Ml1o//ZNRt2YexyQUaKU="
    ];
    trusted-users = [ "root" "@wheel" "builder" ];
  };
  nix.extraOptions = ''
    !include /etc/nix/access_tokens.conf
  '';
  nixpkgs.config.allowUnfree = true;

  security.sops.secrets."nix/access_tokens" = {
    path = "/etc/nix/access_tokens.conf";
  };
}
