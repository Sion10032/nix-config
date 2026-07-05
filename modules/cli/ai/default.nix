{ ... }: {
  imports = [
    ./pi-coding-agent
  ];

  home-manager.sharedModules = [
    ({ ... }: {
      programs.opencode = {
        enable = true;
      };
    })
  ];
}
