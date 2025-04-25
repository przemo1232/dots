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
        bash /etc/nixos/scripts/autorotateslistener.sh
      '';
      Restart = "always";
      RestartSec = 5;
    };
  };
}
