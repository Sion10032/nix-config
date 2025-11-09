{ config, lib, pkgs, ... }: {
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [
      https://mirror.tuna.tsinghua.edu.cn/nix-channels/store
      https://mirror.ustc.edu.cn/nix-channels/store
    ];
  };
  nixpkgs.config.allowUnfree = true;
}
