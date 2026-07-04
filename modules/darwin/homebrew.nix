{ ... }: {
  homebrew = {
    enable = true;
    onActivation ={
      cleanup = "zap";
    };

    # enableZshIntegration = true;
    enableFishIntegration = true;

    user = "sion";
  };

  nix-homebrew = {
    enable = true;
    # enableRosetta = true;
    user = "sion";
    enableFishIntegration = true;
    extraEnv = {
      HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles";
      HOMEBREW_API_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles/api";
    };
  };
}
