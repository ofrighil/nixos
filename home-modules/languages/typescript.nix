{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.home-modules.languages.typescript;
in
{
  options.home-modules.languages.typescript.enable = lib.mkEnableOption "TypeScript";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      prettier
      typescript-language-server
    ];
  };
}
