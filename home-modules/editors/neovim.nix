{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.home-modules.editors.neovim;
in
{
  options.home-modules.editors.neovim.enable = lib.mkEnableOption "Neovim";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ tree-sitter ];

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      sideloadInitLua = true;
    };
  };
}
