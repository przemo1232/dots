{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Cursor theming
    glib
    nwg-look
    catppuccin-gtk
  ];

  home.sessionVariables.GTK_THEME = "Catppuccin-Latte-Rosewater";
  home.sessionVariables.XCURSOR_THEME = "Catppuccin-Latte-Rosewater";
  home.sessionVariables.XCURSOR_SIZE = "16";

  nixpkgs.config.packageOverrides = pkgs: {
    catppuccin-gtk = pkgs.catppuccin-gtk.override {
      accents = [ "rosewater" ]; # You can specify multiple accents here to output multiple themes 
      size = "standard";
      variant = "latte";
    };
  };
}
