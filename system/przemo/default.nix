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
    ./amd.nix
  ];
  services.upower.enable = false;
  services.flatpak.enable = true;
  services.zerotierone = {
  enable = true;
  joinNetworks = [
    "8bd5124fd65ad30c"
  ];
};
}

