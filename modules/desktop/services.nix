{ config, pkgs, ... }:

{
  services.displayManager.noctalia-greeter = {
    enable = true;
    passwordless-sync-users = [ "luke" ];
    settings = {
      cursor = {
        theme = "Vimix-cursors";
        size = 24;
        path = pkgs.vimix-cursors;
      };
    };
  };
  # Provides the Secret portal used by some applications.
  services.gnome.gnome-keyring.enable = true;
  qt.enable = true;
  qt.platformTheme = "qt5ct";
  programs.niri.enable = true;
  programs.umbriel.enable = true;
  services.monado = {
    enable = true;
    defaultRuntime = true; # Register as default OpenXR runtime
  };
  services.flatpak.enable = true;

  systemd.user.services.monado.environment = {
    STEAMVR_LH_ENABLE = "1";
    XRT_COMPOSITOR_COMPUTE = "1";
    #IPC_EXIT_WHEN_IDLE = "1";
  };
  services.udev.extraRules = let
    group = "wheel";
  in ''
    # Bigscreen Beyond
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="35bd", ATTRS{idProduct}=="0101", MODE="0660", GROUP="${group}"
    # Bigscreen Beyond Firmware Mode
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="35bd", ATTRS{idProduct}=="4004", MODE="0660", GROUP="${group}"
    # Bigscreen Beyond Error Mode
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="35bd", ATTRS{idProduct}=="1001", MODE="0660", GROUP="${group}"

    # Bigscreen Bigeye
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="35bd", ATTRS{idProduct}=="0202", MODE="0660", GROUP="${group}"
    # Bigscreen Bigeye DFU Mode
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="35bd", ATTRS{idProduct}=="0282", MODE="0660", GROUP="${group}"
  '';
  nix.settings = {
    substituters = [
      "https://cache.nixos-cuda.org"
    ];

    trusted-public-keys = [
      "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
    ];
  };
  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda;
  };
  services.gvfs.enable = true;
  services.udisks2.enable = true;
}
