{ lib, ... }:
{
  imports = [
    ./hyprland.nix
    ./kde.nix
  ];

  options.modules.graphical = lib.mkOption {
    type = lib.types.enum [
      "hyprland"
      "kde"
    ];
  };
}
