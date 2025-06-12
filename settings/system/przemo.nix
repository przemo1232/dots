{ pkgs, secrets, ... }:

{
  powerManagement.enable = false;
  # boot.resumeDevice = "/dev/disk/by-uuid/dev/disk/by-uuid/f12ba31b-b559-47ca-83f7-9eed472b4e8d";
  # Allow Unfree
  nixpkgs.config = {
    allowUnfree = true;
  };
  # Experimental Features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Host name
  networking.hostName = "stellated";
  
  # Timezone
  time.timeZone = "Poland";
  
  # Locale
  i18n.defaultLocale = "en_US.UTF-8";

  # Default User
  users.users.przemo = {
    isNormalUser = true;
    initialHashedPassword = secrets.passwd;
    extraGroups = [
      "wheel"
      "video"
      "audio"
      "openrazor"
    ];
  };

  # zsh default shell
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
}

