{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.home-modules.languages.lua;
in
{
  options.home-modules.languages.lua.enable = lib.mkEnableOption "Haskell";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      lua-language-server
      stylua
    ];
  };
}
