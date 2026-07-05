{ ... }: {
  home-manager.sharedModules = [
    ({ pkgs, config, ... }: {
      programs.pi-coding-agent = {
        enable = true;

        context = ../AGENTS.md;

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
            "npm:@juicesharp/rpiv-todo"
            "npm:pi-zentui"
            "npm:pi-terminal-theme"
          ];
        };
      };

      home.file.".pi/agent/mcp.json".text = ''
        {
          "mcpServers": {
            "context-mode": {
              "command": "context-mode"
            }
          }
        }
      '';

      # disable auto format for pi-lens
      home.file.".pi-lens/config.json".text = ''
        {
          "format": {
            "enabled": false
          }
        }
      '';
    })
  ];
}
