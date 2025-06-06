{ config, pkgs, machine-settings, secrets, user, ... }: let

in {
  imports = [
  ] ++ machine-settings.mkSystemModulePaths pkgs user [
    ./amd.nix
    # ./nvidia-open.nix
    # ./nvidia-pinned.nix
    ./fonts.nix
    ./razer.nix
    ./qmk.nix
    ./pipewire.nix
    # ./plasma.nix
    ./hyprland.nix
    ./gnome-login-manager.nix
    ./polkit.nix
    ./android.nix
    # ./virtual.nix
    #./enableopengl.nix
    ./maestral.nix
    ./bluetooth.nix
    ./protonvpn.nix
    # ./single-gpu-passthrough.nix
    ./thunar.nix
  ];

  programs.kdeconnect.enable = true;

  environment.systemPackages = with pkgs; [
    ntfs3g

    # Celeste Mod Manager
    mons

    # Syncing
    syncthing

    linuxKernel.packages.linux_zen.xone
    
    gparted
    xorg.xhost

    glances
  ];

  # Flatpak
  services.flatpak.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  virtualisation.docker.enable = true;

  services.gvfs.enable = true;

  # env vars
  environment.sessionVariables = rec {
    PROGDIR = "/mnt/Programming/CodingShit";
    CC = "clang";
    NIXPKGS_ALLOW_UNFREE = "1";
  };
  hardware.xpadneo.enable = true;
  hardware.xone.enable = true;

}
