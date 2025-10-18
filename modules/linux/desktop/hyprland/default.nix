{ ... }: {
  imports = [];

  kana.programs = {
    rofi.enable = true;
    dunst.enable = true;
    eww.enable = true;
  };

  programs.hyprland = {
    enable = true;
  };

  # todo use uwsm https://wiki.hyprland.org/Useful-Utilities/Systemd-start/

  home-manager.sharedModules = [ ({ config, pkgs, ... }@inputs: {
    wayland.windowManager.hyprland.enable = true;
    wayland.windowManager.hyprland.settings = {
      # https://github.com/hyprwm/Hyprland/blob/main/example/hyprland.conf
      # https://wiki.hyprland.org/Configuring/Start/

      ### MONITORS ###
      monitor = [
        ",preferred,auto,auto" # name, resolution, position, scale
      ];

      ### MY PROGRAMS ###
      "$terminal" = "kitty";
      "$fileManager" = "thunar";
      "$menu" = "rofi -show drun";

      ### AUTOSTART ###
      exec-once = [ 
        "dnust"
        "eww daemon"
        "hyprpaper"
      ];

      ### PERMISSIONS ###
      # todo

      ### LOOK AND FEEL ###
      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
      };

      ### KEYBINDINGS ###
      "$mod" = "SUPER";
      
      bind = [
        "$mod SHIFT, q, killactive,"
        "$mod, t, exec, $terminal"
        "$mod, e, exec, $fileManager"
        "$mod, SPACE, exec, $menu"
        
        "$mod ALT, q, exit,"

        "$mod, f, togglefloating,"
        # "$mod, P, pseudo," # dwindle
        # "$mod, J, togglesplit," # dwindle

        # Move focus with mod + w/a/s/d
        "$mod, left, movefocus, a"
        "$mod, right, movefocus, d"
        "$mod, up, movefocus, w"
        "$mod, down, movefocus, s"


        # Switch workspaces with mod + [0-9]
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"
        # Move active window to a workspace with mod + SHIFT + [0-9]
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"

        # Scroll through existing workspaces with mod + scroll
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"
      ];

      bindm = [
        # Move/resize windows with mod + LMB/RMB and dragging
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
    };

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