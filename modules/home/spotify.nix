{ lib, pkgs, secrets, inputs, ... }: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in {
  programs.spicetify = {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      adblockify
    ];
     theme = spicePkgs.themes.catppuccin;
     colorScheme = "mocha";
  };

  services.spotifyd = {
    enable = true;
    # settings = {
    #   global = {
    #     username = secrets.spotify-username;
    #     password = secrets.spotify-password;
    #   };
    # };
  };
}
