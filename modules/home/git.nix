{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gitkraken
  ];

  # Git
  programs.git = {
    enable = true;
    userName = "przemo1232";
    userEmail = "p.sobczak01@gmail.com";
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
}
