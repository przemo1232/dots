{ pkgs, machine-settings, ... }:

let
  name = "eww-using-too-much-ram";
in {
  systemd.user.timers.${name} = {
    Unit.Description = "Run ${name} every 15 minutes";
    Timer = {
      OnCalendar = "*:0/15";
      Persistent = true;
    };
    Install.WantedBy = [ "timers.target" ];
  };

  systemd.user.services.${name} = {
    Unit.Description = "Kill eww and reopen bar";

    Service = {
      Type = "oneshot";

      StandardOutput = "journal";
      StandardError = "journal";

      ExecStartPre = [
        "${pkgs.procps}/bin/pgrep -f .eww-wrapped"
      ];
      ExecStart = "${pkgs.hyprland}/bin/hyprctl dispatch exec '${pkgs.eww}/bin/eww open bar'";
    };
  };
}
