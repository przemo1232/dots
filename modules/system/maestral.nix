# Open source drop box alternative
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    maestral
    maestral-gui
  ];
}
