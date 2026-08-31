{ inputs, ... }: {
  nix.settings = {
    extra-substituters = [ "https://noctalia.cachix.org" ];
    extra-trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
  };

  home-manager.sharedModules = [
    ({ pkgs, ... }: {
      imports = [
        inputs.noctalia.homeModules.default
      ];

      programs.noctalia = {
        enable = true;
        package = pkgs.noctalia;

        # settings = {
        # };
      };
    })
  ];
}