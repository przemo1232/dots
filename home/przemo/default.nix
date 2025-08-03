# this is a function with variables
{ config, pkgs, secrets, username, homeDirectory, stateVersion, machine-settings, inputs, lib, ... }:

{
  # home directory
  home = {
    inherit username homeDirectory stateVersion;
  };
  
  # always export this as env vars
  home.sessionVariables = {
    NIXPKGS_ALLOW_UNFREE = "1";
    NIXPKGS_ALLOW_BROKEN = "1";
  };

  # import from relative path in first array, ++ merges arrays and shit after that modifies the second array to use modules/home as base path
  imports = [
    ./vscode.nix
  ] ++ machine-settings.mkHomeModulePaths username lib [
    ./gaming.nix
    ./terminal-kitty.nix
    ./git.nix
    ./spotify.nix
    # ./python.nix
  ];
  
  # append this to the $PATH
  home.sessionPath = [
    "$HOME/.cargo/bin"
  ];

  # add packages, with pkgs adds "pkgs." to every entry
  home.packages = with pkgs; [
    firefox
    pavucontrol
    openssl
    github-desktop
    eza
    signal-desktop
    # roccat-tools
    gpu-screen-recorder-gtk
    libqalculate
    yafc-ce
    steam-run
    droidcam
    ckan
    lm_sensors
    libreoffice
    vlc

    vesktop # discord
  ];

  # different provider for packages
  services.flatpak = {
    remotes = {
      "flathub" = "https://flathub.org/repo/flathub.flatpakrepo";
      "flathub-beta" = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
    };
    packages = [
      "flathub:com.discordapp.Discord//stable"
    ];
  };
}

