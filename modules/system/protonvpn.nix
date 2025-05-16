{ user, secrets, ... }: 

{
  # Run this command to import something for example
  # sudo nmcli connection import type wireguard file usnyprotonvpn.conf

  networking.firewall = {
    logReversePathDrops = true;
     # wireguard trips rpfilter up
     extraCommands = ''
       ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --sport 51820 -j RETURN
       ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --dport 51820 -j RETURN
     '';
     extraStopCommands = ''
       ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --sport 51820 -j RETURN || true
       ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --dport 51820 -j RETURN || true
     '';
  };
}
