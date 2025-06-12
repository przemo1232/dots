{ machine-settings, pkgs, user, lib, ... }:

{
  # system wide imports
  imports = [
  ] ++ machine-settings.mkSystemModulePaths user lib [
    ./fonts.nix
    ./polkit.nix
    ./pipewire.nix
    ./plasma.nix
    ./sddm.nix
    ./nvidia.nix
  ];
  services.upower.enable = false;
  services.flatpak.enable = true;
}

