{ config, lib, pkgs, ... }: 
let
  cfg = config.home-modules.languages.ocaml;
in {
  options.home-modules.languages.ocaml.enable = lib.mkEnableOption "OCaml";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      dune
      ocaml
      ocamlformat
      ocamlPackages.ocaml-lsp
      ocamlPackages.utop
      opam
    ];
  };
}
