{ ... }: {
  home-manager.sharedModules = [
    ({ pkgs, config, ... }: {
      programs.opencode = {
        enable = true;
      };
      programs.claude-code = {
        enable = true;
      };
      programs.codex = {
        enable = true;
      };
      programs.pi-coding-agent = {
        enable = true;
        configDir = "${config.xdg.configHome}/pi/agent";

        extraPackages = [ pkgs.nodejs ];

        settings = {
          showHardwareCursor =  true;
          enableInstallTelemetry = false;
          retry = {
            enabled = true;
            maxRetries = 3;
          };
          theme = "terminal";
          packages = [
            "npm:@dreki-gg/pi-ask-mode"
            "npm:pi-lens"
            "npm:context-mode"
            "npm:pi-web-access"
            "npm:pi-markdown-preview"
            "npm:@narumitw/pi-goal"
            "npm:pi-zentui"
            "npm:pi-terminal-theme"
          ];
        };
      };
      # programs.uv = {
      #   enable = true;
      #   settings = {
      #     pip.index-url = "https://mirrors.ustc.edu.cn/pypi/simple";
      #   };
      # };
    })
  ];
}
