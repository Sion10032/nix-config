{ ... }: {
  home-manager.sharedModules = [
    ({ pkgs, ... }: {
      home.packages = with pkgs; [
        maple-mono.Normal-NF-CN
        noto-fonts-cjk-sans
      ];
    })
  ];
}
