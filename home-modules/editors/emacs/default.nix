{ config, lib, ... }: 
let
  cfg = config.home-modules.editors.emacs;
in {
  options.home-modules.editors.emacs.enable = lib.mkEnableOption "Emacs";

  config = lib.mkIf cfg.enable {
    programs.emacs.enable = true;
  };
}
