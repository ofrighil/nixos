{ lib, config, ... }:
{
  config = lib.mkIf (config.modules.desktop == "kde" ) {
    services.xserver.enable = true;

    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;
  };
}
