{ ... }:

let
  username = "luke";
  fullName = "Luke Finkbeiner";
in
{
  users.users.${username} = {
    isNormalUser = true;
    description = fullName;
    extraGroups = [ "wheel" "networkmanager" "adbusers" ];
  };

  home-manager.users.${username} = {
    imports = [
      ../modules/umbriel.nix
      ../modules/niri.nix
      ../modules/noctalia.nix
      ../modules/pkgslazy.nix
    ];

    home.username = username;
    home.homeDirectory = "/home/${username}";
    home.stateVersion = "25.11";
  };
}
