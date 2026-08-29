{ lib, config, ... }:
{
  config = lib.mkIf (config.modules.desktops == "hyprland" ) {
    programs.hyprland.enable = true;

    # services.displayManager.sddm.enable = true;
    # services.displayManager.sddm.wayland.enable = true;
  };
}
