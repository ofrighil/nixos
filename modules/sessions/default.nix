{ lib, ... }:
{
  imports = [
    ./hyprland.nix
    ./kde.nix
  ];
  options.modules.desktops = lib.mkOption {
    type = lib.types.enum [
      "hyprland"
      "kde"
    ];
    default = "kde";
  };

  config.services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
}
