# This is crazy ass stuff I'm about to do
# On the fent type shit
{ user, pkgs, ... }:

{
  systemd.user.services.orientation-watcher = {
    description = "Orientation Change Handler";
    wantedBy = [ "default.target" ];
    script = ''
      ${pkgs.bash}/bin/bash -l -c /etc/nixos/scripts/autorotatelistener.sh
    '';
    serviceConfig = {
      Restart = "always";
      RestartSec = 5;
    };
  };
}
