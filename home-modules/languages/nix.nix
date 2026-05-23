{ config, lib, pkgs, ... }: 
let
  cfg = config.home-modules.languages.nix;
in {
  options.home-modules.languages.nix.enable = lib.mkEnableOption "Nix";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      nil
      nixfmt
    ];
  };
}
