{ config, lib, pkgs, ... }:
let
  cfg = config.modules.editors.neovim;
in {
  options.modules.editors.neovim.enable = lib.mkEnableOption "Neovim";

  config = lib.mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
  };
} 
