{ ... }: {
  home-manager.sharedModules = [
    ({ pkgs, ... }: {
      programs.vscode = {
        enable = true;
      };
    })
  ];
}
