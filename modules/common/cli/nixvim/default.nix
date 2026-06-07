{ inputs, ... }: {
  home-manager.sharedModules = [
    ({ pkgs, ... }: {
      imports = [
        inputs.nixvim.homeModules.nixvim
      ];
      programs.nixvim = {
        enable = true;
        version.enableNixpkgsReleaseCheck = false;

        plugins.neo-tree = {
          enable = true;
          settings = {
            close_if_last_window = false;
            enable_git_status = true;
            window = {
              postition = "left";
              width = 40;
            };
          };
        };
      };
    })
  ];
}
