{ inputs, ... }:
{
  imports = [
    inputs.umbriel.homeModules.default
  ];

  programs.umbriel = {
    enable = true;

    settings = {
      general.autostart = [ "noctalia" ];

      layout = {
        gap = 5;
        mode = "scrolling";
      };

      appearance = {
        prefer_no_csd = true;
        border_width = 2;
        corner_radius = 10;

        blur = {
          enabled = true;
          optimized = true;
          passes = 2;
          radius = 3;
          noise = 0.02;
          brightness = 0.9;
          contrast = 0.9;
          saturation = 1.1;
        };
      };

      window_rule = [
        {
          blur = true;
          blur_optimized = true;
        }
        {
          match.app_id = "^dev.noctalia.Noctalia$";
          default_floating = true;
          default_floating_size_px = {
            width = 1020;
            height = 900;
          };
        }
      ];

      layer_rule = [
        {
          match.namespace =
            "^noctalia-(bar-[^\"]+|notification|dock|panel|attached-panel|osd)$";
          blur = true;
          blur_ignore_alpha = 0.6;
          blur_optimized = false;
        }
      ];

      keybinds = {
        # Existing bindings
        "Mod+Return" = "spawn ghostty";
        "Mod+Q" = "window-close";
        "Mod" = "spawn noctalia msg panel-toggle launcher";

        # Navigation and window management
        "Mod+MouseMiddle" = "layout-scroll-drag";
        "Mod+Left" = "window-focus-left";
        "Mod+Right" = "window-focus-right";
        "Mod+T" = "window-toggle-floating";
        "Mod+D" = "overview-toggle";

        # Noctalia controls
        "Mod+Space" = "spawn noctalia msg panel-toggle launcher";
        "Mod+S" = "spawn noctalia msg panel-toggle control-center";
        "Mod+Comma" = "spawn noctalia msg settings-toggle";
        "Alt+Tab" = "spawn noctalia msg window-switcher hold";
        "Mod+Shift+A" = "spawn noctalia msg screenshot-annotate";
        "Mod+Ctrl+A" = "spawn noctalia msg annotate";

        # Volume and brightness
        "XF86AudioRaiseVolume" = "spawn noctalia msg volume-up";
        "XF86AudioLowerVolume" = "spawn noctalia msg volume-down";
        "XF86AudioMute" = "spawn noctalia msg volume-mute";
        "XF86MonBrightnessUp" = "spawn noctalia msg brightness-up";
        "XF86MonBrightnessDown" = "spawn noctalia msg brightness-down";

        # Allow an escape from manually enabled shortcut passthrough
        "Mod+Shift+Escape" = {
          action = "shortcuts-inhibit-toggle";
          allow_when_inhibited = true;
          repeat = false;
        };
      };
    };
  };
}
