user: { pkgs, ... }: {  
  # enable network function for thunar
  services.gvfs = {
    enable = true;
    package = pkgs.gvfs;
  };

  home-manager.users.${user} = { pkgs, ... }: {
    home.packages = with pkgs; [
      xfce.thunar
    ];
  };
}
