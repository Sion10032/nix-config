{ ... }: {
  home-manager.sharedModules = [
    ({ pkgs, lib, ... }: {
      programs.pi-coding-agent = {
        enable = true;

        context = ../AGENTS.md;

        extraPackages = [ pkgs.nodejs ];

        settings = {
          defaultProvider = "opencode";
          defaultModel = "deepseek-v4-flash-free";

          showHardwareCursor =  true;
          enableInstallTelemetry = false;
          retry = {
            enabled = true;
            maxRetries = 3;
          };
          editorPaddingX = 1;
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

      # 确保 ~/.pi/agent/auth.json 存在；不存在则用默认模板创建，避免敏感凭据进入仓库
      home.activation.createPiAuth = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        if [[ ! -f "$HOME/.pi/agent/auth.json" ]]; then
          $DRY_RUN_CMD mkdir -p "$HOME/.pi/agent"
          $DRY_RUN_CMD install -m 600 /dev/null "$HOME/.pi/agent/auth.json"
          $DRY_RUN_CMD printf '%s' '{"opencode":{"type":"api_key","key":"public"}}' > "$HOME/.pi/agent/auth.json"
          echo "Created $HOME/.pi/agent/auth.json"
        fi
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
