{ machine-settings, pkgs, user, lib, ... }:

{
  imports = [
  ] ++ machine-settings.mkSystemModulePaths user lib [
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

