{ system, nixpkgs, pkgs2405, home-manager, user, secrets, stateVersion, machine-settings, inputs, ... }:

let
  username = user;
  homeDirectory = "/home/${user}";
  configHome = "/etc/nixos";

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
    config.xdg.configHome = configHome;
    overlays = [
      inputs.firefox-nightly.overlays.default
      inputs.nur.overlays.default
    ];
  };

  home-nix = "/etc/nixos/home/${username}";
in
{
  "${user}" = home-manager.lib.homeManagerConfiguration {
    pkgs = pkgs;
    extraSpecialArgs = { inherit pkgs2405 username homeDirectory secrets stateVersion inputs machine-settings; }; 
    modules = [
      machine-settings.home-settings
      inputs.nixvim.homeManagerModules.nixvim
      inputs.flatpaks.homeManagerModules.default
      inputs.spicetify-nix.homeManagerModules.spicetify
      home-nix
    ];
  };
}
