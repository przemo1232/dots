{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Cursor theming
    glib
    nwg-look
    catppuccin-gtk
  ];
}
