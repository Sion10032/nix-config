{ ... }: {
  programs.floorp = {
    enable = true;
    languagePacks = [ "zh-CN" "en-US" ];
  };
}
