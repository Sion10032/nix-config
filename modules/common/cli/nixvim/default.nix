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
        };
      };
    })
  ];
}
