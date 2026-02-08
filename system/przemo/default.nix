{ machine-settings, pkgs, secrets, user, lib, ... }:

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
      secrets.factorionetwork
      secrets.gtnhnetwork
    ];
  };
  virtualisation.docker.enable = true;
  environment.sessionVariables = rec {
    CC = "clang";
    RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
  };
}
