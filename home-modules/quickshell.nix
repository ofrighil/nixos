{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.home-modules.quickshell;
in
{
  imports = [ ./languages/qml.nix ];

  options.home-modules.quickshell.enable = lib.mkEnableOption "Quickshell";

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.quickshell ];

    home-modules.languages.qml.enable = true;

    xdg.configFile."quickshell".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/dotfiles/quickshell";
  };
}
