{
  inputs = {
    ## Impermanence ##
    impermanence.url = "github:nix-community/impermanence";
    
    ## System packages ##
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # for rust-analyzer
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    xdg-desktop-portal-hyprland.url = "github:hyprwm/xdg-desktop-portal-hyprland";

    ## Home-manager packager ##
    home-manager.url = "github:nix-community/home-manager";
    helix-master = {
      url = "github:SoraTenshi/helix/new-daily-driver";
      # inputs.nci.follows = "nci";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hypr-contrib.url = "github:hyprwm/contrib";
    flatpaks.url = "github:GermanBread/declarative-flatpak?rev=fb31283f55f06b489f2baf920201e8eb73c9a0d3";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zig.url = "github:mitchellh/zig-overlay";
    waterfox = {
      url = "github:sammypanda/nixos-waterfox";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-nightly = {
      url = "github:nix-community/flake-firefox-nightly";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs2405.url = "github:NixOS/nixpkgs/nixos-24.05";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
  };

  outputs = {
    self, nixpkgs, hyprland, xdg-desktop-portal-hyprland, home-manager, helix-master, hypr-contrib, flatpaks, impermanence, nixvim, fenix, zig, waterfox, firefox-nightly, nixpkgs2405, nur, ... 
  }@inputs: let
    secrets = import "/etc/nixos/secrets.nix";
    machine-settings = import ./settings/machine-settings.nix;
    
    system = machine-settings.system;
    host = machine-settings.host;
    user = machine-settings.user;
    stateVersion = machine-settings.stateVersion;

    mkNixOS = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit nixpkgs system stateVersion machine-settings host user secrets inputs; };
      modules = [
        ## Impermanence ##
        "${inputs.impermanence}/nixos.nix"

        ## System ##
        (./configuration.nix)
        machine-settings.system-settings
        # Adds the NUR overlay
        nur.modules.nixos.default
        # NUR modules to import
        nur.legacyPackages."${system}".repos.iopq.modules.xraya
        
        (./machines + "/${machine-settings.host}/hardware.nix")
        ## User ##
        (./system + "/${machine-settings.user}/default.nix")
        
      ];
    };
  in {
  
    homeConfigurations = import ./home/home-configuration.nix { 
      inherit home-manager nixpkgs machine-settings secrets inputs host user system stateVersion; 
    };

    nixosConfigurations = {
      "${machine-settings.host}" = mkNixOS;
      "nixos" = mkNixOS;
    };
  };
}
