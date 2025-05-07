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
    ./graphics.nix
    ./haskell.nix
    ./retro-emulation.nix
    ./spotify.nix
    # ./c-clang.nix
    ./catppuccin.nix
  ];

  # Git
  programs.git = {
    enable = true;
    userName = "LemonjamesD";
    userEmail = "lemon@lemonjamesd.com";
    extraConfig = {
      credential.helper = "store";
      safe.directory = "*";
      init.defaultBranch = "main";
    };
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = true;
    };
  };

  # zsh
  programs.zsh = {
    enable = true;
    shellAliases = {
      rebuild-system = ''echo -e "\x1b[0;32mNixOs\x1b[0m" && sudo nixos-rebuild switch --flake /etc/nixos --impure && echo -e "\x1b[0;32mHome-manager\x1b[0m" && home-manager switch --flake /etc/nixos --impure'';
      rebuild-system-upgrade = ''echo -e "\x1b[0;32mNixOs\x1b[0m" && sudo nixos-rebuild switch --flake /etc/nixos --impure --upgrade && echo -e "\x1b[0;32mHome-manager\x1b[0m" && home-manager switch --flake /etc/nixos --impure'';
      rebuild-system-trace = ''echo -e "\x1b[0;32mNixOs\x1b[0m" && sudo nixos-rebuild switch --show-trace --flake /etc/nixos --impure && echo -e "\x1b[0;32mHome-manager\x1b[0m" && home-manager switch --show-trace --flake /etc/nixos --impure'';
      update-dots = ''export GOBACK="$(pwd)" && cd /etc/nixos && git pull && ./update-dots.sh && cd $GOBACK'';
      notif = "ntfy send";
      ls = "eza";
      "..." = "../..";
      "...." = "../../..";
      "....." = "../../../..";
    };
    plugins = [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.8.0";
          sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
        };
      }
    ];
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "darkblood";
    };
  };

  home.sessionPath = [
    "$HOME/.cargo/bin"
    "/usr/bin"
  ];

  home.sessionVariables.GTK_THEME = "Catppuccin-Latte-Rosewater";
  home.sessionVariables.XCURSOR_THEME = "Catppuccin-Latte-Rosewater";
  home.sessionVariables.XCURSOR_SIZE = "16";

  nixpkgs.config.packageOverrides = pkgs: {
    catppuccin-gtk = pkgs.catppuccin-gtk.override {
      accents = [ "rosewater" ]; # You can specify multiple accents here to output multiple themes 
      size = "standard";
      variant = "latte";
    };
  };
  
  home.packages = with pkgs; [  
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

    # Screenshot
    inputs.hypr-contrib.packages.${pkgs.system}.grimblast
    slurp

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
  ];

  services.flatpak = {
    remotes = {
      "flathub" = "https://flathub.org/repo/flathub.flatpakrepo";
      "flathub-beta" = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
    };
    packages = [
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
