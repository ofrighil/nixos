{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.home-modules.languages.dafny;
in
{
  options.home-modules.languages.dafny.enable = lib.mkEnableOption "Dafny";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ dafny ];
  };
}
