{ pkgs, ... }: {
  home.packages = with pkgs; [
    maple-mono-SC-NF
    noto-fonts-cjk-sans
  ];
}
