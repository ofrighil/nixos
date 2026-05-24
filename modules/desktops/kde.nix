{ lib, config, ... }:
{
  config = lib.mkIf (config.modules.desktops == "kde" ) {
    services.xserver.enable = true;

    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;
  };
}
