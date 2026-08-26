{ config, lib, pkgs, ... }: 
let
  cfg = config.home-modules.languages.haskell;
in {
  options.home-modules.languages.haskell.enable = lib.mkEnableOption "Haskell";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs.haskell.packages.ghc98; [
      cabal-install
      ghc
      haskell-language-server
    ];
  };
}
