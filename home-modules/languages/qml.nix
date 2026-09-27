{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.home-modules.languages.qml;
in
{
  options.home-modules.languages.qml.enable = lib.mkEnableOption "QML";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      qt6.qtdeclarative
    ];
  };
}
