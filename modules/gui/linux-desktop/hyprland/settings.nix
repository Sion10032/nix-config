{ sLib, lib, ... }: let 
  mkModBind = keys: lib.generators.mkLuaInline "mod .. \" + ${keys}\"";
  mkDsp     = args: lib.generators.mkLuaInline "hl.dsp.${args}";
in sLib.mergeAttrs [
  # appearance
  {
    config = {
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;

        resize_on_border = true;
        allow_tearing = true;

        layout = "dwindle";
      };

      decoration = {
        rounding = 10;
        rounding_power = 2;

        active_opacity   = 1.0;
        inactive_opacity = 1.0;
      };

      animations = {
        enabled = true;
      };
    };

    animation = [
      { leaf = "global"; enabled = true; speed = 2; bezier = "default"; }
      { leaf = "windowsIn";  enabled = true; speed = 2; bezier = "linear"; style = "popin 87%"; }
      { leaf = "windowsOut"; enabled = true; speed = 2; bezier = "linear"; style = "popin 87%"; }
    ];
  }
  # input
  {
    config = {
      input =  {
        kb_layout  = "us";
        kb_variant = "";
        kb_model   = "";
        kb_options = "";
        kb_rules   = "";

        follow_mouse = 1;

        sensitivity = 0;

        touchpad = {
            natural_scroll = true;
        };
      };

      gestures = {
        workspace_swipe_touch = true;
      };
    };

    gesture = {
      fingers = 3;
      direction = "horizontal";
      action = "workspace";
    };
  }
  # bindings
  {
    mod = {
      _var = "SUPER";
    };
    noc = {
      _var = "noctalia msg ";
    };

    terminal = {
      _var = "kitty";
    };
    fileManager = {
      _var = "nemo";
    };
    taskManager = {
      _var = "messioncenter";
    };

    bind = lib.map (args: { _args = args; }) (
      [
        [ (mkModBind "ALT + Q") (mkDsp "exec_cmd(\"command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'\")") ]

        [ "ALT + SPACE"       (mkDsp "exec_cmd(noc .. \"panel-toggle launcher\")") ]
        [ "ALT + TAB"         (mkDsp "exec_cmd(noc .. \"window-switcher\")")       ]
        [ (mkModBind "comma") (mkDsp "exec_cmd(noc .. \"settings-toggle\")")       ]

        [ (mkModBind "T")              (mkDsp "exec_cmd(terminal)")                         ]
        [ (mkModBind "E")              (mkDsp "exec_cmd(fileManager)")                      ]
        [ (mkModBind "SHIFT + ESCAPE") (mkDsp "exec_cmd(taskManager)")                      ]
        [ (mkModBind "SHIFT + Q")      (mkDsp "window.close()")                             ]
        [ (mkModBind "Z")              (mkDsp "window.fullscreen({ action = \"toggle\" })") ]
        [ (mkModBind "F")              (mkDsp "window.float({ action = \"toggle\" })")      ]
        [ (mkModBind "P")              (mkDsp "window.pseudo()")                            ]

        [ (mkModBind "A")     (mkDsp "focus({ direction = \"left\" })")  ]
        [ (mkModBind "D")     (mkDsp "focus({ direction = \"right\" })") ]
        [ (mkModBind "W")     (mkDsp "focus({ direction = \"up\" })")    ]
        [ (mkModBind "S")     (mkDsp "focus({ direction = \"down\" })")  ]
        [ (mkModBind "left")  (mkDsp "focus({ direction = \"left\" })")  ]
        [ (mkModBind "right") (mkDsp "focus({ direction = \"right\" })") ]
        [ (mkModBind "up")    (mkDsp "focus({ direction = \"up\" })")    ]
        [ (mkModBind "down")  (mkDsp "focus({ direction = \"down\" })")  ]
      ]
      ++ lib.genList (i: let key = lib.toString (lib.mod (i + 1) 10); in [
        (mkModBind key)               (mkDsp "focus({ workspace = ${key}})")
      ]) 10
      ++ lib.genList (i: let key = lib.toString (lib.mod (i + 1) 10); in [
        (mkModBind "SHIFT + ${key}")  (mkDsp "window.move({ workspace = ${key}})")
      ]) 10
      ++ [
        # Scroll through existing workspaces with mainMod + scroll
        [ (mkModBind "mouse_down") (mkDsp "focus({ workspace = \"e+1\" }")  ]
        [ (mkModBind "mouse_up")   (mkDsp "focus({ direction = \"e-1\" })") ]
        # Move/resize windows with mainMod + LMB/RMB and dragging
        [ (mkModBind "mouse:272") (mkDsp "window.drag()")   { mouse = true; } ]
        [ (mkModBind "mouse:273") (mkDsp "window.resize()") { mouse = true; } ]
      ]
      ++ [
        # Laptop multimedia keys for volume and LCD brightness
        [ "XF86AudioRaiseVolume"  (mkDsp "exec_cmd(\"wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+\")") { locked = true; repeating = true; } ]
        [ "XF86AudioLowerVolume"  (mkDsp "exec_cmd(\"wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-\")")      { locked = true; repeating = true; } ]
        [ "XF86AudioMute"         (mkDsp "exec_cmd(\"wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle\")")     { locked = true; repeating = true; } ]
        [ "XF86AudioMicMute"      (mkDsp "exec_cmd(\"wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle\")")   { locked = true; repeating = true; } ]
        [ "XF86MonBrightnessUp"   (mkDsp "exec_cmd(\"brightnessctl -e4 -n2 set 5%+\")")                  { locked = true; repeating = true; } ]
        [ "XF86MonBrightnessDown" (mkDsp "exec_cmd(\"brightnessctl -e4 -n2 set 5%-\")")                  { locked = true; repeating = true; } ]
      ]
      ++ [
        [ "XF86AudioNext"  (mkDsp "exec_cmd(\"playerctl next\")")       { locked = true; } ]
        [ "XF86AudioPause" (mkDsp "exec_cmd(\"playerctl play-pause\")") { locked = true; } ]
        [ "XF86AudioPlay"  (mkDsp "exec_cmd(\"playerctl play-pause\")") { locked = true; } ]
        [ "XF86AudioPrev"  (mkDsp "exec_cmd(\"playerctl previous\")")   { locked = true; } ]
      ]
    );
  }
  # window rules
  {
    window_rule = [
      {
        # Fix some dragging issues with XWayland
        name  = "fix-xwayland-drags";
        match = {
            class      = "^$";
            title      = "^$";
            xwayland   = true;
            float      = true;
            fullscreen = false;
            pin        = false;
        };

        no_focus = true;
      }
    ];
  }
]