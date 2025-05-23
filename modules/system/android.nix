{ pkgs, lib, ... }:

{
  virtualisation.waydroid.enable = true;
  programs.adb.enable = true;
  # services.udev.packages = with pkgs; [
    # android-udev-rules
  # ];
  environment.systemPackages = with pkgs; [
    android-studio
  ];
  environment.persistence."/nix/persist/systems" = {
    directories = lib.mkAfter [
      "/var/lib/waydroid"
      "/usr/share/waydroid-extra"
    ];
  };
}
