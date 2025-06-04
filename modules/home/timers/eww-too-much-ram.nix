{ pkgs, machine-settings, ... }: let
  name =  builtins.trace "eww dir: ${pkgs.eww}/bin" "eww-using-too-much-ram";
in {
  systemd.user.timers.${name} = {
    Timer = {
      OnCalendar = "*:0/15";
      Persistent = true;
    };

    Install = {
      WantedBy = [ "timers.target" ];
    };
  };


  systemd.user.services.${name} = {
    Service = {
      Type = "oneshot";

      StandardOutput = "journal";
      StandardError = "journal";
      
      ExecStart = "${pkgs.bash}/bin/bash -c ''
        echo '[eww] killing old instance'
        pgrep -f .eww-wrapped | xargs --no-run-if-empty kill || true
        echo '[eww] dispatching open bar'
        hyprctl dispatch exec \"eww open bar\"
      ''";

    };
  };
}
