{ ... }: {
  home-manager.sharedModules = [
    ({ pkgs, ... }: {
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
            "npm:@sion10032/pi-modes"
            # "npm:pi-lens"
            "npm:context-mode"
            "npm:pi-loop-police"
            "npm:pi-web-access"
            # "npm:@narumitw/pi-goal"
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

      home.file.".pi/pi-modes.json".source = ./pi-modes.json;

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
