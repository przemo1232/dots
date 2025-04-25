# This is crazy ass stuff I'm about to do
# On the fent type shit
{ user, pkgs, ... }:

{
  systemd.services.orientation-watcher = {
    description = "Orientation Change Handler";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    script = ''
      ${pkgs.bash}/bin/bash -l -c /etc/nixos/scripts/autorotatelistener.sh
    '';
    serviceConfig = {
      User = "${user}";
      Restart = "always";
      RestartSec = 5;
    };
  };
}
