{ pkgs, ... }:

{
  services.xserver.enable = true;
  services.xserver.desktopManager.plasma6.enable = true;
}
