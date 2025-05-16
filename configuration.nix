{ config, lib, pkgs, machine-settings, secrets, ... }: let
in {
  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
  };

  networking.networkmanager.enable = true;
  # should fix nmtui not saving network info problem :pray:
  services.gnome.gnome-keyring.enable = true;

  # Make FHS work
  virtualisation.podman.enable = true;

  environment.defaultPackages = lib.mkForce [];
  environment.systemPackages = with pkgs; [
    # Setup home-manager
    home-manager

    # Audio
    pipewire

    # Edit Files
    vim

    # Get files from the web
    wget
    git

    # See system info
    hyfetch
    
    # Verify commits and such
    gnupg
    pinentry-curses
  ];

  environment.sessionVariables = rec {
    EDITOR = "hx";
  };

  # Stupid stupid git thing
  # https://github.com/NixOS/nixpkgs/issues/24311
  environment.extraInit = ''
    # Do not want this in the environment. NixOS always sets it and does not
    # provide any option not to, so I must unset it myself via the
    # environment.extraInit option.
    unset -v SSH_ASKPASS
  '';

  # GNUPG
  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
    enableSSHSupport = true;
  };
  
  # Remove old builds
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  nix.extraOptions = ''
    min-free = ${toString (1024 * 1024 * 1024)}
    max-free = ${toString (10 * 1024 * 1024 * 1024)}
  '';

  system.autoUpgrade.enable = true;
  system.stateVersion = machine-settings.stateVersion;
  environment.persistence."/nix/persist/systems" = {
    hideMounts = true;
    directories = [
      "/var/lib/nixos"
      "/etc/NetworkManager"
    ];
    files = [];
  };
  nix.settings.trusted-users = [ "root" "lemon" "orange" "pumpkin" ];
  
  users.users.root.initialHashedPassword = secrets.passwd;
}

