{ pkgs, ... }: let
  commonProfile = {
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

      "terminal.integrated.enableImages" = true;

      "window.commandCenter" = false;
      "window.autoDetectColorScheme" = true;
      "workbench.colorTheme" = "Default Dark+";
      "workbench.preferredLightColorTheme" = "Default Light+";
      "workbench.preferredDarkColorTheme" = "Default Dark+";
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
