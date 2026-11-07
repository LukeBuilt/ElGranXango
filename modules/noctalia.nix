{ inputs, programs, pkgs, ... }:

{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia = {
    enable = true;
    settings = {
      bar = {
        order = [ "default" ];

        default = {
          background_opacity = 0.5;
          capsule_opacity = 0.5;
          capsule_group = [];
          center = [ "active_window" ];
          concave_edge_corners = false;
          end = [
            "tray"
            "bar"
            "status"
            "notifications"
            "bluetooth"
            "battery"
            "network"
            "volume"
            "brightness"
            "clock"
            "session"
          ];
          margin_ends = 0;
          radius = 0;
          shadow = false;
          start = [
            "control-center"
            "clipboard"
            "launcher"
            "workspaces"
          ];
          thickness = 25;
          widget_spacing = 12;
        };
      };

      brightness = {
        enable_ddcutil = true;
      };

      control_center = {
        sidebar_section = "none";
      };

      dock = {
        background_opacity = 0.5;
        concave_edge_corners = false;
        enabled = true;
        margin_edge = 8;
        shadow = false;
      };

      nightlight = {
        enabled = true;
      };

      notification = {
        background_opacity = 0.88;
      };

      osd = {
        background_opacity = 0.88;
        kinds = {
          media = false;
        };
      };

      plugins = {
        enabled = [
          "pozzoo/hassio"
          "icefish/phone-connect"
        ];
      };

      plugin_settings = {
        "icefish/phone-connect" = {
          details_placement = "floating";
        };

        "pozzoo/hassio" = {
          entity_manager_open_near_click = true;
          entity_manager_position = "auto";
          ha_url = "192.168.4.55";
          ha_token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJkZDk3Mzc2Nzg1OGQ0ZjM2OTliNDk5YmNlMWViNjNlYSIsImlhdCI6MTc5MzA1NzAyMiwiZXhwIjoyMTA4NDE3MDIyfQ.3wt2yYuc5ycm0EHmKu-y13cXZxYrowPji2Xujs-8sBc";
        };
      };

      shell = {
        app_icon_color = "primary";
        app_icon_colorize = false;
        avatar_path = "/home/luke/Downloads/images.jpg";
        corner_radius_scale = 1.0;
        polkit_agent = true;
        telemetry_enabled = true;

        greeter_sync = {
          auto_sync = true;
        };

        panel = {
          clipboard_position = "auto";
          control_center_placement = "floating";
          launcher_position = "auto";
          open_near_click_clipboard = true;
          open_near_click_control_center = true;
          open_near_click_launcher = true;
          open_near_click_session = true;
          session_placement = "floating";
          transparency_mode = "glass";
          wallpaper_placement = "floating";
        };
      };

      theme = {
        mode = "dark";
        source = "wallpaper";
        wallpaper_scheme = "m3-content";

        templates = {
          builtin_ids = [
            "gtk3"
            "gtk4"
            "kcolorscheme"
            "niri"
          ];
          community_ids = [ "chromium-based" ];
        };
      };

      wallpaper = {
        default = {
          path = "/home/luke/Pictures/vintage-style-tropical-paradise-beach.jpg";
        };
      };

      widget = {
        bar = {
          type = "icefish/phone-connect:bar";
        };

        clock = {
          format = "{:%a %b %-d %-I:%M %p}";
        };

        control-center = {
          glyph = "components";
        };

        network = {
          show_label = false;
        };

        status = {
          type = "pozzoo/hassio:status";
        };

        taskbar = {
          show_window_title = true;
        };

        tray = {
          detached_panel = true;
          drawer = true;
        };

        volume = {
          show_label = false;
        };

        workspaces = {
          hide_when_empty = false;
          style = "minimal";
        };
      };
    };
  };

}
