{ ... }:

{
  
  services.displayManager.gdm.enable = true;

  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "dvorak";
  };
}
