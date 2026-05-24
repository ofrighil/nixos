{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.home-modules.languages.rust;
in
{
  options.home-modules.languages.rust.enable = lib.mkEnableOption "Rust";
  config = lib.mkIf cfg.enable {
    home.packages = [
      (pkgs.rust-bin.stable.latest.default.override {
        extensions = [
          "rust-src"
          "rust-analyzer"
        ];
      })
    ];
  };
}
