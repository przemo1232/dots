{ ... }:

{
  services.xserver = {
    layout = "us";
    xkbVariant = "dvorak";
    displayManager.gdm.enable = true;
  };
}
