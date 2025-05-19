{ pkgs, ... }: {
  imports = [
    ./termscp
  ];
  
  home.packages = with pkgs; [
    xfce.thunar
    # gvfs
  ];

  # enable network function for thunar
  #config.services.gvfs = {
  #  enable = true;
  #  package = pkgs.gvfs;
  #};

  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
  };
}
