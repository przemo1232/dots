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
  ] ++ machine-settings.mkHomeModulePaths [
    ./gaming.nix
    ./terminal-kitty.nix
    ./git.nix
  ];
  
  home.sessionPath = [
    "$HOME/.cargo/bin"
  ];

  home.packages = with pkgs; [
    firefox
    pavucontrol
    openssl

    vencord # discord
  ];

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

