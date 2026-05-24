{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.home-modules.languages.agda;
in
{
  options.home-modules.languages.agda.enable = lib.mkEnableOption "Agda";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      (agda.withPackages (p: [ p.standard-library ]))
    ];

    home.file.".agda/defaults".text = ''
      standard-library
    '';
  };
}
