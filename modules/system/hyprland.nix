args@{ config, pkgs, machine-settings, inputs, ...}: let

in {
  imports = [
    ./wayland.nix
    # ./hyprland-tuigreet.nix
    ./gnome-login-manager.nix
  ];

  environment.systemPackages = with pkgs; [
    hyprpaper
    eww # wayland version is now deprecated yippeee
    hyprpicker
    hypridle
    hyprlock

    # Screenshot
    hyprshot
    satty
  ];

  programs.hyprland.package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    # enableNvidiaPatches = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ inputs.xdg-desktop-portal-hyprland ];
  };
}
