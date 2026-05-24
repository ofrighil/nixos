{ lib, ... }:
{
  imports = [ ./kde.nix ];
  options.modules.desktops = lib.mkOption {
    type = lib.types.enum [ "kde" ];
    default = "kde";
  };

  config.services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
}
