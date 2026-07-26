{ ... }: let
  userSettings = {
    # Fonts
    buffer_font_size = 16;
    buffer_font_family = "Maple Mono Normal NF CN";

    ui_font_size = 16;
    ui_font_family = "MiSans";

    terminal.font_size = 15;

    # UI
    status_bar.show_active_file = true;
    title_bar.show_sign_in = false;
    project_panel.dock = "left";
    outline_panel.dock = "left";
    collaboration_panel.button = false;
    git_panel = {
      group_by = "none";
      tree_view = true;
      dock = "left";
    };
    theme = {
      mode = "system";
      light = "GitHub Light";
      dark = "GitHub Dark Dimmed";
    };
    icon_theme = {
      mode = "system";
      light = "Catppuccin Latte";
      dark = "Catppuccin Mocha";
    };

    format_on_save = "off";

    telemetry = {
      diagnostics = false;
      metrics = false;
    };

    disable_ai = true;
  };

  userKeymaps = [
    {
      context = "Terminal";
      bindings = builtins.listToAttrs (
        map (keys: { name = keys; value = [ "terminal::SendKeystroke" keys ]; }) [
          "ctrl-h"
          "ctrl-n"
          "ctrl-p"
          "ctrl-q"
          "ctrl-s"
          "ctrl-t"
        ]
      );
    }
  ];
in {
  home-manager.sharedModules = [
    ({ ... }: {
      programs.zed-editor = {
        enable = true;
        extensions = [
          "dockerfile"
          "html"
          "lua"
          "nix"

          "github-theme"
          "catppuccin-icons"
        ];

        inherit userSettings;
        inherit userKeymaps;
      };
    })
  ];
}
