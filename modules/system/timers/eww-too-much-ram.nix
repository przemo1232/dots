{ pkgs, machine-settings, ... }: let
  name = "eww-using-too-much-ram";
in {
  systemd.timers.${name} = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "15m";
      OnUnitActivation = "15m";
      Unit = "eww-using-too-much-ram.service";
    };
  };

  systemd.services.${name} = {
    script = ''
      ${pkgs.eww}/bin/eww close bar
      ${pkgs.eww}/bin/eww open bar
    '';
    serviceConfig = {
      Type = "oneshot";
      User = machine-settings.user;
    };
  };
}
