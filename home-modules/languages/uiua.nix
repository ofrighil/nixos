{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.home-modules.languages.uiua;
in
{
  options.home-modules.languages.uiua.enable = lib.mkEnableOption "Uiua";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      uiua
      uiua386
      (writeShellScriptBin "uiua-edit" ''
        exec ghostty --font-family="" --font-family=Uiua386 -e nvim "$@"
      '')
    ];
  };
}
