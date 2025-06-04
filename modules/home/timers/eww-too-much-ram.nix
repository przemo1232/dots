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
      ExecStart = ''
        ${pkgs.bash}/bin/bash -c '(pkill ".eww-wrapped" || true) && ${pkgs.eww}/bin/eww open bar &'
      '';
    };
  };
}
