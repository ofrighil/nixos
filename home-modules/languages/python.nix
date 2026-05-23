{ config, lib, pkgs, ... }: 
let
  cfg = config.home-modules.languages.python;
in {
  options.home-modules.languages.python.enable = lib.mkEnableOption "Python";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      python315
      ruff
      ty
    ];
  };
}
