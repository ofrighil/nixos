{ lib, config, pkgs, ... }:
{
  config = lib.mkIf (config.modules.graphical == "hyprland" ) (
    lib.mkMerge [
      {
        programs.hyprland.enable = true;

        programs.hyprlock.enable = true;
        # services.hypridle.enable = true;

        xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

        environment.systemPackages = with pkgs; [
          brightnessctl
          dbus
          grim
          playerctl
          slurp
        ];

        systemd.user.targets.hyprland-session = {
          description = "Hyprland compositor session";
          bindsTo = [ "graphical-session.target" ];
          wants = [ "graphical-session-pre.target" ];
          after = [ "graphical-session-pre.target" ];
        };

        systemd.user.services.hyprpolkitagent = {
          description = "Hyprland polkit authentication agent";
          wantedBy = [ "graphical-session.target" ];
          after = [ "graphical-session.target" ];
          partOf = [ "graphical-session.target" ];
          serviceConfig = {
            ExecStart = "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent";
            Restart = "on-failure";
            RestartSec = 1;
          };
        };
      }
      (import ./lib/tuigreet.nix { inherit lib pkgs; } { cmd = "start-hyprland"; })
    ]
  );
}
