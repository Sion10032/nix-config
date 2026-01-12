{ ... }: {
  home-manager.sharedModules = [
    ({ pkgs, lib, ... }: {
      programs.claude-code = {
        enable = true;
      };
      programs.uv = {
        enable = true;
        settings = {
          pip.index-url = "https://mirrors.ustc.edu.cn/pypi/simple";
        };
      };
    })
  ];
}
