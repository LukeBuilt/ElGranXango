{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    kdePackages.kdeconnect-kde
    glib
    zed-editor
    ghostty
    ungoogled-chromium
    nautilus
    spotify
    opencode
    element-desktop
    prismlauncher
    adwsteamgtk
    nemo
    pcmanfm
    adwaita-qt6
    udiskie
    gh
  ];
  nixpkgs.config.allowUnfree = true;
}
