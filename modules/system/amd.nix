{ pkgs, ... }: 

{
  services.xserver.videoDrivers = [ "amdgpu" ];
  # hardware.opengl.driSupport = true; DEPRECATED
  # For 32 bit applications
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  hardware.graphics.extraPackages = with pkgs; [
    amdvlk
    mesa.drivers
  ];
}
