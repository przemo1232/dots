{ pkgs, machine-settings, secrets, username, homeDirectory, stateVersion, inputs, ... }:

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
    ./gaming.nix
    ./vulkan-glfw.nix
    ./rust.nix
    ./zig.nix
    ./c-clang.nix
    ./graphics.nix
    ./haskell.nix
    ./retro-emulation.nix
    ./spotify.nix
    ./catppuccin-latte-rosewater-theme.nix
    ./terminal-kitty.nix
    ./git.nix
    ./archive-tools.nix
  ];

  home.sessionPath = [
    "$HOME/.cargo/bin"
    "/usr/bin"
  ];
  
  home.packages = with pkgs; [
    remote-touchpad
  
    libqalculate
  
    # converts shit to json
    jc
  
    whatsapp-for-linux

    kdePackages.kdenlive

    torrential

    sxiv
    feh
    vlc
    gifsicle

    # browser
    firefox-nightly-bin

    # macro thing
    xnee

    # Notes
    obsidian

    # Network
    netcat
    socat

    # image
    gimp

    # Password
    keepassxc

    # Pipewire
    pavucontrol
    helvum

    # Directory control
    tree
    eza

    # Xorg
    xorg.xrandr

    # Audio
    audacity

    htop

    stremio

    godot_4

    zoom-us
  ];

  services.flatpak = {
    remotes = {
      "flathub" = "https://flathub.org/repo/flathub.flatpakrepo";
      "flathub-beta" = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
    };
    packages = [
      "flathub:org.freedesktop.portal.RemoteDesktop//stable"
      "flathub:io.github.everestapi.Olympus//stable"
      "flathub:com.discordapp.Discord//stable"
      "flathub:de.shorsh.discord-screenaudio//stable"
      "flathub:xyz.armcord.ArmCord//stable"
      "flathub:net.waterfox.waterfox//stable"
      # roblox
      "flathub:org.vinegarhq.Sober//stable"
    ];
  };
}
