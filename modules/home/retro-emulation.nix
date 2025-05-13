{ pkgs, pkgs2405, ... }:

{
  home.packages = with pkgs; [
    torzu # Switch
    cemu # Wii U
    cdecrypt # Decript WII U shit?
    rpcs3 # PS3

    retroarchFull
  ];
}
