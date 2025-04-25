# This is crazy ass stuff I'm about to do
# On the fent type shit
{ pkgs, ... }:

{
  systemd.services.orientation-watcher = {
    description = "Orientation Change Handler";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = ''
        ${pkgs.bash}/bin/bash /etc/nixos/scripts/autorotatelistener.sh
      '';
      Restart = "always";
      RestartSec = 5;
    };
  };
}
