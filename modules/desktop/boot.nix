{ config, pkgs, ... }:

{
  # Use the limine EFI boot loader.
  boot.loader.limine.enable = true;
  boot.loader.limine.style.interface.branding = "";
  boot.loader.efi.canTouchEfiVariables = true;
  # Enable the cachyos kernel for Bigscreen Beyond support
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;
  # Enable plymouth for cool boot animations
  boot = {
    plymouth = {
      enable = true;
      theme = "rings";
      themePackages = with pkgs; [
        # By default we would install all themes
        (adi1090x-plymouth-themes.override {
          selected_themes = [ "rings" ];
        })
      ];
    };

    # Enable "Silent boot"
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "rd.udev.log_level=3"
      "rd.systemd.show_status=auto"
    ];

    loader.timeout = 0;
  };
}
