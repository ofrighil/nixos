{ lib, pkgs }:
{
  cmd,
  config ? ../greeter,
}:
let
  greeter = lib.escapeShellArgs [
    "env"
    "QSGREET_CMD=${cmd}"
    "XDG_CACHE_HOME=/var/cache/qsgreet"
    "XDG_STATE_HOME=/var/cache/qsgreet"
    (lib.getExe pkgs.cage)
    "-s"
    "--"
    (lib.getExe pkgs.quickshell)
    "--config"
    "greeter"
  ];
in
{
  environment.etc."xdg/quickshell/greeter".source = config;

  services.greetd = {
    enable = true;
    settings.default_session = {
      command = greeter;
      user = "greeter";
    };
  };

  systemd.tmpfiles.rules = [
    "d '/var/cache/qsgreet' - greeter greeter - -"
  ];
}
