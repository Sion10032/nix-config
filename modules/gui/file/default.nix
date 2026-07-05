{ sLib, ... }:
{
  home-manager.sharedModules = [
    ({ pkgs, ... }: {
      home.packages = with pkgs; [
        peazip
      ];
    })
  ];
}
// (sLib.forLinux.attrs {
  # enable network function for thunar
  services.gvfs = {
    enable = true;
    package = pkgs.gvfs;
  };

  home-manager.sharedModules = [
    ({ pkgs, ... }: {
      home.packages = with pkgs; [
        xfce.thunar
      ];
    })
  ];
})
