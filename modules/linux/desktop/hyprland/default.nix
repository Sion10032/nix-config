{ kanaFlakeRoot, ... }@inputs: {
  imports = [];

  kana.programs = {
    rofi.enable = true;
    dunst.enable = true;
    eww.enable = true;
    # ashell.enable = true;
  };

  programs.hyprland = {
    enable = true;
  };

  # todo use uwsm https://wiki.hyprland.org/Useful-Utilities/Systemd-start/

  home-manager.sharedModules = [ ({ config, pkgs, ... }@inputs: {
    wayland.windowManager.hyprland.enable = true;
    wayland.windowManager.hyprland.settings = import ./settings.nix inputs;

    services.hyprpaper = {
      enable = true;
      settings = {
        # ipc = "on";
        # splash = false;
        # splash_offset = 2.0;

        # preload =
        #   [ "/share/wallpapers/buttons.png" "/share/wallpapers/cat_pacman.png" ];

        # wallpaper = [
        #   "DP-3,/share/wallpapers/buttons.png"
        #   "DP-1,/share/wallpapers/cat_pacman.png"
        # ];
      };
    };
  }) ];
}