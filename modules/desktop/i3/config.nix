{ pkgs, config, ... }:
let
  i3StatusRsConfigFile = "${config.home.homeDirectory}/${config.xdg.configFile."i3status-rust/config-default.toml".target}";
  modifier = "Mod1";
  menu = "rofi -show drun";
  terminal = "kitty";
  fileManager = "thunar";
in {
  inherit modifier terminal menu;
  keybindings = {
    "${modifier}+Shift+q" = "kill";
    "${modifier}+space" = "exec ${menu}";

    "${modifier}+e" = "exec ${fileManager}";
    "${modifier}+t" = "exec ${terminal}";

    "${modifier}+a" = "focus left";
    "${modifier}+s" = "focus down";
    "${modifier}+w" = "focus up";
    "${modifier}+d" = "focus right";
    "${modifier}+q" = "focus parent";

    "${modifier}+Shift+a" = "move left";
    "${modifier}+Shift+s" = "move down";
    "${modifier}+Shift+w" = "move up";
    "${modifier}+Shift+d" = "move right";

    "${modifier}+h" = "split h";
    "${modifier}+v" = "split v";
    "${modifier}+z" = "fullscreen toggle";

    #"${modifier}+s" = "layout stacking";
    #"${modifier}+w" = "layout tabbed";
    "${modifier}+l" = "layout toggle";

    # "${modifier}+Shift+space" = "floating toggle";
    # "${modifier}+space" = "focus mode_toggle";

    "${modifier}+Shift+minus" = "move scratchpad";
    "${modifier}+minus" = "scratchpad show";

    "${modifier}+1" = "workspace number 1";
    "${modifier}+2" = "workspace number 2";
    "${modifier}+3" = "workspace number 3";
    "${modifier}+4" = "workspace number 4";
    "${modifier}+5" = "workspace number 5";
    "${modifier}+6" = "workspace number 6";
    "${modifier}+7" = "workspace number 7";
    "${modifier}+8" = "workspace number 8";
    "${modifier}+9" = "workspace number 9";
    "${modifier}+0" = "workspace number 10";

    "${modifier}+Shift+1" =
      "move container to workspace number 1";
    "${modifier}+Shift+2" =
      "move container to workspace number 2";
    "${modifier}+Shift+3" =
      "move container to workspace number 3";
    "${modifier}+Shift+4" =
      "move container to workspace number 4";
    "${modifier}+Shift+5" =
      "move container to workspace number 5";
    "${modifier}+Shift+6" =
      "move container to workspace number 6";
    "${modifier}+Shift+7" =
      "move container to workspace number 7";
    "${modifier}+Shift+8" =
      "move container to workspace number 8";
    "${modifier}+Shift+9" =
      "move container to workspace number 9";
    "${modifier}+Shift+0" =
      "move container to workspace number 10";

    "${modifier}+Shift+c" = "reload";
    "${modifier}+Shift+r" = "restart";
    "${modifier}+Shift+e" =
      "exec i3-nagbar -t warning -m 'Do you want to exit i3?' -b 'Yes' 'i3-msg exit'";

    "${modifier}+r" = "mode resize";
  };
  modes = {
    resize = {
      Escape = "mode default";
      Return = "mode default";
      Up = "resize shrink height 10 px or 10 ppt";
      Down = "resize grow height 10 px or 10 ppt";
      Left = "resize shrink width 10 px or 10 ppt";
      Right = "resize grow width 10 px or 10 ppt";
    };
  };
  startup = [
    # set wallpaper
    # { command = "feh --bg-scale /path/to/image"; always = true; notification = false; }
  ];
  gaps = {
    inner = 6;
    outer = 2;
  };
  window.titlebar = false;
  bars = [
    {
      command = "${pkgs.i3}/bin/i3bar"; # i3bar_command

      fonts = {
        names = [
          "Maple Mono Normal NF CN"
          # "Noto Sans Mono CJK SC"
        ];
        size = 10.0;
      };
      mode = "dock";
      hiddenState = "hide";
      position = "top";
      trayOutput = "primary";
      
      workspaceButtons = true;
      workspaceNumbers = true;
      # strip_workspace_numbers no
      statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ${i3StatusRsConfigFile}";

      colors = {
        background = "#000000";
        statusline = "#ffffff";
        separator = "#666666";
        focusedWorkspace = {
          border = "#4c7899";
          background = "#285577";
          text = "#ffffff";
        };
        activeWorkspace = {
          border = "#333333";
          background = "#5f676a";
          text = "#ffffff";
        };
        inactiveWorkspace = {
          border = "#333333";
          background = "#222222";
          text = "#888888";
        };
        urgentWorkspace = {
          border = "#2f343a";
          background = "#900000";
          text = "#ffffff";
        };
        bindingMode = {
          border = "#2f343a";
          background = "#900000";
          text = "#ffffff";
        };
      };

      # Description: Extra configuration lines for this bar.
      # Type: strings concatenated with "\n"
      extraConfig = "";
    }
  ];
}
