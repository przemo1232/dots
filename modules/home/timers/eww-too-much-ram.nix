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
      ExecStart = "${pkgs.bash}/bin/bash -c ''
        ${pkgs.procps}/bin/pgrep -f \".eww-wrapped\" | xargs --no-run-if-empty kill || true
        ${pkgs.eww}/bin/eww daemon &
        sleep 0.2
        ${pkgs.eww}/bin/eww open bar
      ''";
    };
  };
}
