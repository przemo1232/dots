{ ... }:

{
  # Git
  programs.git = {
    enable = true;
    userName = "lambdalemon";
    userEmail = "lemonjameslem@protonmail.com";
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
