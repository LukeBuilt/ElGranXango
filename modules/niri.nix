{ inputs, programs, pkgs, ... }:

{
  imports = [
    inputs.niri.homeModules.config
  ];

  programs.niri.package = inputs.niri.packages.${pkgs.system}.niri-unstable;
  home.packages = [
    pkgs.xwayland-satellite
    pkgs.ddcutil
    pkgs.nwg-look
    pkgs.adw-gtk3
    pkgs.papirus-icon-theme
    pkgs.vimix-cursors
  ];

  xdg.configFile."niri/config.kdl" = {
    force = true;
    text = ''

      input {
        warp-mouse-to-focus
      }

      environment {
        XDG_CURRENT_DESKTOP "niri"
        QT_QPA_PLATFORM "wayland"
        ELECTRON_OZONE_PLATFORM_HINT "auto"
        QT_QPA_PLATFORMTHEME "qt6ct"
      }

      //include "/home/luke/.config/niri/noctalia.kdl"

      screenshot-path "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"

      prefer-no-csd

      spawn-at-startup "noctalia"

      window-rule {
        geometry-corner-radius 10
        clip-to-geometry true
      }

      window-rule {
        match app-id="dev.noctalia.Noctalia"
        open-floating true
        default-column-width { fixed 1080; }
        default-window-height { fixed 920; }
      }

      // Blur behind windows, using the content behind them rather than the wallpaper.
      window-rule {
        background-effect {
          blur true
          xray false
        }
      }

      debug {
        honor-xdg-activation-with-invalid-serial
      }


      gestures {
          hot-corners {
              off
          }
      }


      binds {

        // === System & Overview ===
        Mod+D repeat=false { toggle-overview; }
        Mod+Tab repeat=false { toggle-overview; }
        Mod+Shift+Slash { show-hotkey-overlay; }
        Mod+Space { spawn-sh "noctalia msg panel-toggle launcher"; }
        Mod+S { spawn-sh "noctalia msg panel-toggle control-center"; }
        Mod+Comma { spawn-sh "noctalia msg settings-toggle"; }
        Alt+Tab { spawn-sh "noctalia msg window-switcher hold"; }

        XF86AudioRaiseVolume { spawn-sh "noctalia msg volume-up"; }
        XF86AudioLowerVolume { spawn-sh "noctalia msg volume-down"; }
        XF86AudioMute { spawn-sh "noctalia msg volume-mute"; }
        XF86MonBrightnessUp { spawn-sh "noctalia msg brightness-up"; }
        XF86MonBrightnessDown { spawn-sh "noctalia msg brightness-down"; }

        // === Window Management ===
        Mod+Q repeat=false { close-window; }
        Mod+F { maximize-column; }
        Mod+Shift+F { fullscreen-window; }
        Mod+Shift+T { toggle-window-floating; }
        Mod+Shift+V { switch-focus-between-floating-and-tiling; }
        Mod+W { toggle-column-tabbed-display; }

        // === Focus Navigation ===
        Mod+Left  { focus-column-left; }
        Mod+Down  { focus-window-down; }
        Mod+Up    { focus-window-up; }
        Mod+Right { focus-column-right; }
        Mod+H     { focus-column-left; }
        Mod+J     { focus-window-down; }
        Mod+K     { focus-window-up; }
        Mod+L     { focus-column-right; }

        // === Window Movement ===
        Mod+Shift+Left  { move-column-left; }
        Mod+Shift+Down  { move-window-down; }
        Mod+Shift+Up    { move-window-up; }
        Mod+Shift+Right { move-column-right; }
        Mod+Shift+H     { move-column-left; }
        Mod+Shift+J     { move-window-down; }
        Mod+Shift+K     { move-window-up; }
        Mod+Shift+L     { move-column-right; }

        // === Column Navigation ===
        Mod+Home { focus-column-first; }
        Mod+End  { focus-column-last; }
        Mod+Ctrl+Home { move-column-to-first; }
        Mod+Ctrl+End  { move-column-to-last; }

        // === Monitor Navigation ===
        Mod+Ctrl+Left  { focus-monitor-left; }
        //Mod+Ctrl+Down  { focus-monitor-down; }
        //Mod+Ctrl+Up    { focus-monitor-up; }
        Mod+Ctrl+Right { focus-monitor-right; }
        Mod+Ctrl+H     { focus-monitor-left; }
        Mod+Ctrl+J     { focus-monitor-down; }
        Mod+Ctrl+K     { focus-monitor-up; }
        Mod+Ctrl+L     { focus-monitor-right; }

        // === Move to Monitor ===
        Mod+Shift+Ctrl+Left  { move-column-to-monitor-left; }
        Mod+Shift+Ctrl+Down  { move-column-to-monitor-down; }
        Mod+Shift+Ctrl+Up    { move-column-to-monitor-up; }
        Mod+Shift+Ctrl+Right { move-column-to-monitor-right; }
        Mod+Shift+Ctrl+H     { move-column-to-monitor-left; }
        Mod+Shift+Ctrl+J     { move-column-to-monitor-down; }
        Mod+Shift+Ctrl+K     { move-column-to-monitor-up; }
        Mod+Shift+Ctrl+L     { move-column-to-monitor-right; }

        // === Workspace Navigation ===
        Mod+Page_Down      { focus-workspace-down; }
        Mod+Page_Up        { focus-workspace-up; }
        Mod+U              { focus-workspace-down; }
        Mod+I              { focus-workspace-up; }
        Mod+Ctrl+Down { move-column-to-workspace-down; }
        Mod+Ctrl+Up   { move-column-to-workspace-up; }
        Mod+Ctrl+U         { move-column-to-workspace-down; }
        Mod+Ctrl+I         { move-column-to-workspace-up; }

        // === Move Workspaces ===
        Mod+Shift+Page_Down { move-workspace-down; }
        Mod+Shift+Page_Up   { move-workspace-up; }
        Mod+Shift+U         { move-workspace-down; }
        Mod+Shift+I         { move-workspace-up; }

        // === Mouse Wheel Navigation ===
        Mod+WheelScrollDown      cooldown-ms=150 { focus-workspace-down; }
        Mod+WheelScrollUp        cooldown-ms=150 { focus-workspace-up; }
        Mod+Ctrl+WheelScrollDown cooldown-ms=150 { move-column-to-workspace-down; }
        Mod+Ctrl+WheelScrollUp   cooldown-ms=150 { move-column-to-workspace-up; }

        Mod+WheelScrollRight      { focus-column-right; }
        Mod+WheelScrollLeft       { focus-column-left; }
        Mod+Ctrl+WheelScrollRight { move-column-right; }
        Mod+Ctrl+WheelScrollLeft  { move-column-left; }

        Mod+Shift+WheelScrollDown      { focus-column-right; }
        Mod+Shift+WheelScrollUp        { focus-column-left; }
        Mod+Ctrl+Shift+WheelScrollDown { move-column-right; }
        Mod+Ctrl+Shift+WheelScrollUp   { move-column-left; }

        // === Numbered Workspaces ===
        Mod+1 { focus-workspace 1; }
        Mod+2 { focus-workspace 2; }
        Mod+3 { focus-workspace 3; }
        Mod+4 { focus-workspace 4; }
        Mod+5 { focus-workspace 5; }
        Mod+6 { focus-workspace 6; }
        Mod+7 { focus-workspace 7; }
        Mod+8 { focus-workspace 8; }
        Mod+9 { focus-workspace 9; }

        // === Move to Numbered Workspaces ===
        Mod+Shift+1 { move-column-to-workspace 1; }
        Mod+Shift+2 { move-column-to-workspace 2; }
        Mod+Shift+3 { move-column-to-workspace 3; }
        Mod+Shift+4 { move-column-to-workspace 4; }
        Mod+Shift+5 { move-column-to-workspace 5; }
        Mod+Shift+6 { move-column-to-workspace 6; }
        Mod+Shift+7 { move-column-to-workspace 7; }
        Mod+Shift+8 { move-column-to-workspace 8; }
        Mod+Shift+9 { move-column-to-workspace 9; }

        // === Column Management ===
        Mod+BracketLeft  { consume-or-expel-window-left; }
        Mod+BracketRight { consume-or-expel-window-right; }
        Mod+Period { expel-window-from-column; }

        // === Sizing & Layout ===
        Mod+R { switch-preset-column-width; }
        Mod+Shift+R { switch-preset-window-height; }
        Mod+Ctrl+R { reset-window-height; }
        Mod+Ctrl+F { expand-column-to-available-width; }
        Mod+C { center-column; }
        Mod+Ctrl+C { center-visible-columns; }

        // === Manual Sizing ===
        Mod+Minus { set-column-width "-10%"; }
        Mod+Equal { set-column-width "+10%"; }
        Mod+Shift+Minus { set-window-height "-10%"; }
        Mod+Shift+Equal { set-window-height "+10%"; }

        // === Screenshots ===
        XF86Launch1 { screenshot; }
        Ctrl+XF86Launch1 { screenshot-screen; }
        Alt+XF86Launch1 { screenshot-window; }
        Print { screenshot; }
        Ctrl+Print { screenshot-screen; }
        Alt+Print { screenshot-window; }
        // Windows-style alternatives
        Super+Shift+S { screenshot; }
        Ctrl+Super+Shift+S { screenshot-screen; }
        Alt+Super+Shift+S { screenshot-window; }
        // === System Controls ===
        Mod+Escape allow-inhibiting=false { toggle-keyboard-shortcuts-inhibit; }
        Mod+Shift+P { power-off-monitors; }
      }

      // Noctalia surfaces: use content behind them rather than xray blur.
      layer-rule {
        match namespace="^noctalia-(bar-[^\"]+|notification|dock|panel|attached-panel|osd)$"
        background-effect {
          xray false
        }
      }

      // Blur behind Noctalia's window switcher.
      layer-rule {
        match namespace="noctalia-window-switcher"
        background-effect {
          blur true
          xray false
        }
      }

      // Option 2: stationary wallpaper visible behind workspaces.
      layer-rule {
        match namespace="^noctalia-wallpaper"
        place-within-backdrop true
      }
      // opacity rule for frosted windows
      window-rule {
          match app-id=r#"^com\.mitchellh\.ghostty$"#
          match app-id=r#"^dev\.zed\.Zed$"#
          match app-id=r#"^org\.gnome\.Nautilus$"#

          opacity 0.90

          background-effect {
              blur true
          }
      }

      window-rule {
          match is-focused=true

          shadow {
              on
              softness 30
              spread 6
              offset x=0 y=4
              color "#00000070"
          }
      }

      layout {
        gaps 8
        background-color "transparent"
        border {
          off
          width 1
        }
        focus-ring {
          off
          width 1
        }
        shadow {
          on
          softness 30
          spread 2
          offset x=0 y=4
          draw-behind-window true
          color "#00000050"
        }
      }

      overview {
        workspace-shadow {
          off
        }
      }

      // Global blur tuning.
      blur {
        passes 2
        offset 3.0
        noise 0.03
        saturation 1.0
      }

      // Lock and suspend when the lid closes.
      switch-events {
        lid-close {
          spawn "noctalia" "msg" "session" "lock-and-suspend"
        }
      }
    '';
  };

  xdg.configFile."noctalia/config.toml" = {
    force = true;
    text = ''
      [shell]
      niri_overview_type_to_launch_enabled = true
      niri_overview_close_on_launch_enabled = true
    '';
  };

}
