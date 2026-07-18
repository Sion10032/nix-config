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

      "files.autoGuessEncoding" =  true;

      "terminal.integrated.fontSize" = 14;
      "terminal.integrated.shellIntegration.showCommandGuide" = false;
      # 目前版本vscode启用终端图像显示后，浅色模式下终端字体显示有问题，暂时禁用该功能
      "terminal.integrated.enableImages" = false;
      "terminal.integrated.fontLigatures.enabled" = true;
      "terminal.integrated.defaultProfile.osx" = "fish";

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
        "nixos-vm-dev" = "linux";
        "windows-dev" = "windows";
        "akari" = "linux";
        "ally" = "linux";
        "ume" = "macOS";
      };
    };
  };
in {
  home-manager.sharedModules = [
    ({ pkgs, ... }: {
      programs.vscode = {
        enable = true;
        profiles.default = commonProfile;
      };
    })
  ];
}
