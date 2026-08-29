{ lib, pkgs }:
{ cmd }:
let
  greeter = lib.escapeShellArgs [
    (lib.getExe pkgs.tuigreet)
    "--time"
    "--remember"
    "--remember-session"
    "--cmd" cmd
    "--sessions" "/run/current-system/sw/share/wayland-sessions"
  ];
in
{
  services.greetd = {
    enable = true;
    settings.default_session = {
      command = greeter;
      user = "greeter";
    };
  };

  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal";
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };
}
