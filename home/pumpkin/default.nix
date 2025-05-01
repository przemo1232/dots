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
    ./haskell.nix
    ./rust.nix
    ./vulkan-glfw.nix
    ./gaming.nix
  ];
  
  # zsh
  programs.zsh = {
    enable = true;
    shellAliases = {
      rebuild-system = ''echo -e "\x1b[0;32mNixOs\x1b[0m" && sudo nixos-rebuild switch --flake /etc/nixos --impure && echo -e "\x1b[0;32mHome-manager\x1b[0m" && home-manager switch --flake /etc/nixos --impure'';
      rebuild-system-trace = ''echo -e "\x1b[0;32mNixOs\x1b[0m" && sudo nixos-rebuild switch --show-trace --flake /etc/nixos --impure && echo -e "\x1b[0;32mHome-manager\x1b[0m" && home-manager switch --show-trace --flake /etc/nixos --impure'';
      update-dots = ''export GOBACK="$(pwd)" && cd /etc/nixos && git pull && ./update-dots.sh && cd $GOBACK'';
      notif = "ntfy send";
      "..." = "../..";
      "...." = "../../..";
      "....." = "../../../..";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "darkblood";
    };
  };

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

  programs.gpg = {
    enable = true;
    settings = {
      default-key = "06408C83157BC3925756EBFA1428E0EE4572A07B";
    };
  };

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

    spotify

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
