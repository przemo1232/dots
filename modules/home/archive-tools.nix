{ pkgs, ... }:

{
  home.packages = with pkgs; [  
    # for zipping/unzipping
    p7zip
    zip
    unzip
    rar
    unp
  ];
}
