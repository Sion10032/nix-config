{ config, lib, ... }: let 
  cfg = config.kana.programs.ashell;

  # https://malpenzibo.github.io/ashell/docs/intro
  ashellSettings = {
    log_level = "warn";
    outputs = "All";
    position = "Top";
    # app_launcher_cmd = "rofi -show drun";

    workspaces = {
      enable_workspace_filling = true;
    };

    modules = {
      left = [ [ "appLauncher" "Workspaces" ] "WindowTitle" ];
      center = [ ];
      right = [ "SystemInfo" [  "Tray" "Privacy" "Clock" "Settings" ] ];
    };

    CustomModule = [
      {
        name = "appLauncher";
        icon = "󱗼";
        command = "rofi -show drun";
      }
    ];

    window_title = {
      truncate_title_after_length = 100;
    };

    settings = {
      shutdown_cmd = "shutdown now";
      reboot_cmd = "systemctl reboot";
# lock_cmd = "playerctl --all-players pause; nixGL hyprlock &"
# audio_sinks_more_cmd = "pavucontrol -t 3"
# audio_sources_more_cmd = "pavucontrol -t 4"
# wifi_more_cmd = "nm-connection-editor"
# vpn_more_cmd = "nm-connection-editor"
# bluetooth_more_cmd = "blueberry"
    };

    appearance = {
      style = "Solid";
      opacity = 0.8;

      primary_color = "#7aa2f7";
      success_color = "#9ece6a";
      text_color = "#a9b1d6";
      workspace_colors = [ "#7aa2f7" "#9ece6a" ];
      special_workspace_colors = [ "#7aa2f7" "#9ece6a" ];
    };
    appearance.danger_color = {
      base = "#f7768e";
      weak = "#e0af68";
    };
    appearance.background_color = {
      base = "#1a1b26";
      weak = "#24273a";
      strong = "#414868";
    };
    appearance.secondary_color = {
      base = "#0c0d14";
    };
  };
in {
  options = {
    kana.programs.ashell = {
      enable = lib.mkEnableOption "ashell";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.sharedModules = [
      ({ config, pkgs, ... }@inputs: {
        programs.ashell = {
          enable = true;
          settings = ashellSettings;
        };
      })
    ];
  };
}