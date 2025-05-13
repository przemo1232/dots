{ config, pkgs, secrets, username, homeDirectory, stateVersion, machine-settings, inputs, ... }:

{
  home = {
    inherit username homeDirectory stateVersion;
  };
  
  home.sessionVariables = {
    NIXPKGS_ALLOW_UNFREE = "1";
    NIXPKGS_ALLOW_BROKEN = "1";
  };

  imports = [
    ../lemon/helix.nix
  ] ++ machine-settings.mkHomeModulePaths [
    ./spotify.nix
    ./haskell.nix
    ./rust.nix
    ./vulkan-glfw.nix
    ./gaming.nix
    ./catppuccin-latte-rosewater-theme.nix
    ./terminal-kitty.nix
    ./git.nix
  ];
  
  home.sessionPath = [
    "$HOME/.cargo/bin"
  ];

  home.packages = with pkgs; [
    firefox
  
    syncthing
    keepassxc
    inputs.hypr-contrib.packages.${pkgs.system}.grimblast
    pavucontrol
    kdenlive

    openssl
    brightnessctl

    # Better audio suppression
    noisetorch

    htop
    hyperfine

    glxinfo

    # obsidian
    syncthing

    stremio

    # pi pico
    openocd

    flip-link
  ];

  services.flatpak = {
    remotes = {
      "flathub" = "https://flathub.org/repo/flathub.flatpakrepo";
      "flathub-beta" = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
    };
    packages = [
      "flathub:com.discordapp.Discord//stable"
      "flathub:de.shorsh.discord-screenaudio//stable"
      "flathub:xyz.armcord.ArmCord//stable"
      "flathub:org.vinegarhq.Sober//stable"
    ];
  };
}
