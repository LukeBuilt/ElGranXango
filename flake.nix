{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    # CachyOS kernel
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

    # Nixpkgs XR
    nixpkgs-xr.url = "github:nix-community/nixpkgs-xr";

    # AppManager
    app-manager.url = "github:kem-a/AppManager";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs"; # this line is optional, prevents downloading two versions of nixpkgs but disables cache
    };

    ilya-fedin = {
      url = "github:ilya-fedin/nur-repository";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia-greeter = {
      url = "github:noctalia-dev/noctalia-greeter";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    umbriel.url = "github:noctalia-dev/umbriel";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nix-cachyos-kernel, nixpkgs-xr, app-manager, home-manager, niri, disko, ... }@inputs: {
    nixosConfigurations = {
      my-nixos = nixpkgs.lib.nixosSystem {
        # Make flake inputs available to configuration.nix
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/desktop/configuration.nix
          # nixpkgs-xr module
          nixpkgs-xr.nixosModules.nixpkgs-xr
          disko.nixosModules.disko
          ./hosts/desktop/disko.nix
          home-manager.nixosModules.default
          {
            home-manager.extraSpecialArgs = { inherit inputs; };

            nixpkgs.overlays = [
              nix-cachyos-kernel.overlays.pinned
              inputs.niri.overlays.niri
            ];
          }
        ];
      };
    };
  };
}
