{ config, pkgs, ... }:

{
  hardware.i2c.enable = true;
  hardware.bluetooth.enable = true;

  # Graphics Drivers
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = false;

  # AppImage Support
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
}