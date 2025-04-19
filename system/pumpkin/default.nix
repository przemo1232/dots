{ machine-settings, ... }:

{
  imports = [
  ] ++ machine-settings.mkSystemModulePaths [
    ./fonts.nix
    ./polkit.nix
    ./pipewire.nix
    ./hyprland.nix
    ./amd.nix
    ./bluetooth.nix
    # ./dropbox.nix
    ./maestral.nix
  ];
  services.upower.enable = true;
  services.flatpak.enable = true;
}
