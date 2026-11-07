{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../users/default.nix
      inputs.ilya-fedin.nixosModules.qt6ct
      inputs.noctalia-greeter.nixosModules.default
      inputs.umbriel.nixosModules.default
      # Import modularized desktop configuration
      ../../modules/desktop/boot.nix
      ../../modules/desktop/hardware.nix
      ../../modules/desktop/services.nix
      ../../modules/desktop/multimedia.nix
      ../../modules/desktop/windowing.nix
      ../../modules/desktop/system.nix
    ];
}
