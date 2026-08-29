{ lib, config, ... }:
{
  config = lib.mkIf (config.modules.graphical == "kde" ) {
    services.desktopManager.plasma6.enable = true;

    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };
  };
}
