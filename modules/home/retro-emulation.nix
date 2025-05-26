{ pkgs, pkgs2405, ... }:

{
  home.packages = with pkgs; [
    # torzu # Switch GONE NOW BC DMCA 5/23/2025
    cemu # Wii U
    cdecrypt # Decript WII U shit?
    rpcs3 # PS3

    retroarchFull
  ] ++ [
    pkgs2405.sozu
  ];
}
