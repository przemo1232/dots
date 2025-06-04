{ pkgs, machine-settings, ... }: let
  name =  builtins.trace "eww dir: ${pkgs.eww}/bin" "eww-using-too-much-ram";
in {
  systemd.user.timers.${name} = {
    Timer = {
      OnCalander = "*:0/15";
      Persistent = true;
    };

    Install = {
      WantedBy = [ "timers.target" ];
    };
  };


  systemd.user.services.${name} = {
    Service = {
      Type = "oneshot";
      Environment = [
        "XDG_RUNTIME_DIR=/run/user/1000"
        "WAYLAND_DISPLAY=wayland-0"
        "DISPLAY=:0"
      ];
      ExecStart = "${pkgs.bash}/bin/bash -c ''
        ${pkgs.procps}/bin/pgrep -f \".eww-wrapped\" | xargs --no-run-if-empty kill || true
        hyprctl dispatch exec '${pkgs.eww}/bin/eww open bar'
      ''";
    };
  };
}
