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
        set +e
        ${pkgs.eww}/bin/eww close bar
        set +e
        ${pkgs.eww}/bin/eww open bar
      '';
    };
  };
}
