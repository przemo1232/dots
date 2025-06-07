{ machine-settings, pkgs, user, ... }:

{
  imports = [
  ] ++ machine-settings.mkSystemModulePaths pkgs user [
    ./fonts.nix
    ./polkit.nix
    ./pipewire.nix
    ./plasma.nix
    ./sddm.nix
    ./nvidia.nix
  ];
  services.upower.enable = true;
  services.flatpak.enable = true;
}

