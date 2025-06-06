{ machine-settings, ... }:

{
  imports = [
  ] ++ machine-settings.mkSystemModulePaths [
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

