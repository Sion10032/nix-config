{ pkgs, ... }: {
  services.xserver.desktopManager.xfce.enable = true;

  environment.systemPackages = with pkgs; [
    fluent-gtk-theme
    tela-icon-theme
    xfce4-whiskermenu-plugin
    xfce4-netload-plugin
    xfce4-clipman-plugin
    xfce4-genmon-plugin
  ];
  
  home-manager.sharedModules = [
    ({ pkgs, ... }: {
      gtk = {
        enable = true;

        theme = {
          name = "Fluent-Dark";
          package = pkgs.fluent-gtk-theme;
        };

        iconTheme = {
          name = "Tela-dark";
          package = pkgs.tela-icon-theme;
        };

        # cursorTheme = {
        #   name = "Bibata-Modern-Ice";
        #   package = pkgs.bibata-cursors;
        # };

        colorScheme = "dark";
      };
    })
  ];
}