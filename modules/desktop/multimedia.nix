{ config, pkgs, ... }:

{
  programs.kdeconnect.enable = true;

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 30;
  };

  boot.kernel.sysctl."vm.swappiness" = 30;


  # VR Bigscreen Beyond Stuff
  programs.steam = {
    enable = true;
    package = pkgs.steam.override {
      extraProfile = ''
        # Allows Monado/WiVRn to be used
        # export PRESSURE_VESSEL_IMPORT_OPENXR_1_RUNTIMES=1
        # Fixes timezones on VRChat
        unset TZ
      '';
    };
  };

  xdg.portal = {
    enable = true;

    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];

    config.niri = {
      default = [ "gnome" "gtk" ];

      # Use GTK's file picker, so Nautilus isn't required for this.
      "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];

      # Use GNOME's screencast portal.
      "org.freedesktop.impl.portal.ScreenCast" = [ "gnome" ];
    };
  };
}
