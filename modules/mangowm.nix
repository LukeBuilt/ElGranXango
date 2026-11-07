{ inputs, config, ... }: {
  imports = [
    inputs.mangowm.hmModules.mango
    inputs.noctalia.homeModules.default
  ];

  wayland.windowManager.mango = {
    enable = true;

    settings = {
      source = "${config.home.homeDirectory}/.config/mango/noctalia.conf";
      # Mouse bindings
      mousebind = [
        "SUPER,btn_left,moveresize,curmove"
        "SUPER,btn_right,moveresize,curresize"
      ];

      # Super + scroll wheel: navigate between workspaces with clients
      axisbind = [
        "SUPER,UP,viewtoleft_have_client"
        "SUPER,DOWN,viewtoright_have_client"
      ];

      # Trackpad gestures
      gesture_live = 1;

      gesturebind = [
        # 3-finger swipes: move focus between windows
        "none,left,3,focusdir,left"
        "none,right,3,focusdir,right"
        "none,up,3,focusdir,up"
        "none,down,3,focusdir,down"

        # 4-finger swipes: navigate tags or toggle overview
        "none,right,4,viewprev_have_client"
        "none,left,4,viewnext_have_client"
        "none,up,4,toggleoverview"
        "none,down,4,toggleoverview"
      ];

      # Start Noctalia
      exec_once = [
        "noctalia"
      ];

      # Scroller configuration
      scroller_structs = 20;
      scroller_default_proportion = 0.9;
      scroller_focus_center = 0;
      scroller_prefer_center = 0;
      scroller_prefer_overspread = 1;
      edge_scroller_pointer_focus = 1;
      edge_scroller_focus_allow_speed = 0.0;
      scroller_default_proportion_single = 1.0;
      scroller_proportion_preset = "0.5,0.8,1.0";

      # Blur
      blur = 1;
      blur_layer = 0;
      blur_optimized = 1;
      blur_params_num_passes = 2;
      blur_params_radius = 5;
      blur_params_noise = 0.02;
      blur_params_brightness = 0.9;
      blur_params_contrast = 0.9;
      blur_params_saturation = 1.0;
      layer_animations = 0;

      # Shadows
      shadows = 1;
      layer_shadows = 1;
      shadow_only_floating = 0;
      shadows_size = 4;
      shadows_blur = 12;
      shadows_position_x = 2;
      shadows_position_y = 2;
      shadows_color = "0x000000ff";

      # Appearance
      border_radius = 0;
      border_px = 2;
      focused_opacity = 1.0;
      unfocused_opacity = 0.9;

      gap_inner_horizontal = 5;
      gap_inner_vertical = 5;
      gap_outer_horizontal = 5;
      gap_outer_vertical = 5;

      bind = [
        # Noctalia controls
        "SUPER,space,spawn,noctalia msg panel-toggle launcher"
        "SUPER,s,spawn,noctalia msg panel-toggle control-center"
        "SUPER,comma,spawn,noctalia msg settings-toggle"

        # Window focus
        "SUPER,h,focusdir,left"
        "SUPER,j,focusdir,down"
        "SUPER,k,focusdir,up"
        "SUPER,l,focusdir,right"
        "SUPER,TAB,focuslast"

        # Move windows
        "SUPER+SHIFT,h,move_client,left"
        "SUPER+SHIFT,j,move_client,down"
        "SUPER+SHIFT,k,move_client,up"
        "SUPER+SHIFT,l,move_client,right"

        # Window controls
        "SUPER,q,killclient"
        "SUPER+SHIFT,f,togglefullscreen"
        "SUPER+SHIFT,space,togglefloating"
        "SUPER,c,centerwin"
        "SUPER,z,zoom"

        # Layout and scroller
        "SUPER+SHIFT,Tab,switch_layout"
        "SUPER+CTRL,1,setlayout,scroller"
        "SUPER+CTRL,2,setlayout,tile"
        "SUPER+CTRL,p,switch_proportion_preset"
        "SUPER+CTRL,g,togglegaps"

        # Tags: switch to tags 1–9; Shift moves the focused window there
        "SUPER,1,view,1"
        "SUPER,2,view,2"
        "SUPER,3,view,3"
        "SUPER,4,view,4"
        "SUPER,5,view,5"
        "SUPER,6,view,6"
        "SUPER,7,view,7"
        "SUPER,8,view,8"
        "SUPER,9,view,9"
        "SUPER+SHIFT,1,tag,1"
        "SUPER+SHIFT,2,tag,2"
        "SUPER+SHIFT,3,tag,3"
        "SUPER+SHIFT,4,tag,4"
        "SUPER+SHIFT,5,tag,5"
        "SUPER+SHIFT,6,tag,6"
        "SUPER+SHIFT,7,tag,7"
        "SUPER+SHIFT,8,tag,8"
        "SUPER+SHIFT,9,tag,9"

        # Noctalia audio and brightness
        "NONE,XF86AudioRaiseVolume,spawn,noctalia msg volume-up"
        "NONE,XF86AudioLowerVolume,spawn,noctalia msg volume-down"
        "NONE,XF86AudioMute,spawn,noctalia msg volume-mute"
        "NONE,XF86MonBrightnessUp,spawn,noctalia msg brightness-up"
        "NONE,XF86MonBrightnessDown,spawn,noctalia msg brightness-down"

        # Media playback
        "NONE,XF86AudioNext,spawn,playerctl next"
        "NONE,XF86AudioPrev,spawn,playerctl previous"
        "NONE,XF86AudioPlay,spawn,playerctl play-pause"
      ];
    };
  };

  programs.noctalia = {
    enable = true;
    settings = {
      bar = {
        order = [ "default" ];

        default = {
          center = [ ];
          concave_edge_corners = false;
          end = [
            "tray"
            "notifications"
            "clipboard"
            "bluetooth"
            "battery"
            "network"
            "volume"
            "brightness"
            "group:g1"
          ];
          margin_ends = 0;
          radius = 0;
          start = [ "launcher" "workspaces" "taskbar" ];
          widget_spacing = 12;

          capsule_group = [
            {
              accordion = false;
              accordion_direction = "end";
              border_width = 1.0;
              enabled = true;
              fill = "surface_variant";
              id = "g1";
              members = [ "clock" "control-center" ];
              opacity = 1.0;
              padding = 6.0;
            }
          ];
        };
      };

      shell = {
        app_icon_color = "primary";
        app_icon_colorize = true;
        corner_radius_scale = 0.0;
        telemetry_enabled = true;

        panel = {
          open_near_click_control_center = true;
          open_near_click_session = true;
        };
      };

      theme = {
        source = "wallpaper";

        templates = {
          builtin_ids = [ "gtk3" "gtk4" "kcolorscheme" "qt" ];
        };
      };

      widget = {
        clock = {
          format = "{:%a %b %-d %-I:%M %p}";
        };

        control-center = {
          glyph = "components";
        };

        network = {
          show_label = false;
        };

        taskbar = {
          show_window_title = true;
        };

        volume = {
          show_label = false;
        };

        workspaces = {
          hide_when_empty = true;
        };
      };
    };
  };
}
