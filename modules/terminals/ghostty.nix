{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.terminals.ghostty;
in
{
  options.modules.terminals.ghostty.enable = lib.mkEnableOption "Ghostty";

  config = lib.mkIf cfg.enable {
    # TODO: should this go in user.user.USER.packages instead?
    environment.systemPackages = [
      pkgs.ghostty
    ];
  };
}
