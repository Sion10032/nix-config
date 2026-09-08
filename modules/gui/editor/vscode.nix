{ pkgs, ... }: let
  commonProfile = {
    enableUpdateCheck = false;

    extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide

      mhutchie.git-graph

      yzhang.markdown-all-in-one

      ms-vscode-remote.remote-ssh
      ms-vscode-remote.remote-ssh-edit
      ms-vscode.remote-explorer

      ms-ceintl.vscode-language-pack-zh-hans
    ];
    userSettings = {
      "editor.fontSize" = 16;
      "editor.fontFamily" = "Maple Mono Normal NF CN";
      "editor.fontLigatures" = true;

      "diffEditor.ignoreTrimWhitespace" = false;

      "files.autoGuessEncoding" =  true;

      "terminal.integrated.fontSize" = 14;
      "terminal.integrated.shellIntegration.showCommandGuide" = false;
      # vscode + wayland + amd 780m gpu 开启终端gpu加速会卡死，暂时禁用
      "terminal.integrated.gpuAcceleration" = "off";
      "terminal.integrated.enableImages" = false;
      "terminal.integrated.fontLigatures.enabled" = true;
      "terminal.integrated.allowChords" = false;
      "terminal.integrated.commandsToSkipShell" = [
        "-workbench.action.quickOpen" # ctrl-p
        "-workbench.action.terminal.goToRecentDirectory" # ctrl-g
      ];

      "window.commandCenter" = false;
      "window.autoDetectColorScheme" = true;
      "workbench.colorTheme" = "Dark Modern";
      "workbench.preferredLightColorTheme" = "Light Modern";
      "workbench.preferredDarkColorTheme" = "Dark Modern";

      "update.titleBar" = false;
      "chat.titleBar.signIn.enabled" = false;

      "chat.agent.enabled" = false;

      "nix.enableLanguageServer" = true;

      "remote.SSH.experimental.chat" = false;
      "remote.SSH.useLocalServer" = false;
      "remote.SSH.remotePlatform" = {
        "atelier" = "linux";
        "windows-dev" = "windows";
        "akari" = "linux";
        "ally" = "linux";
        "ume" = "macOS";
      };
    };
  };
in {
  home-manager.sharedModules = [
    ({ ... }: {
      programs.vscode = {
        enable = true;
        profiles.default = commonProfile;
      };
    })
  ];
}
