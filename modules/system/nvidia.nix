{ ... }:

{
  environment.variables = {
    "MUTTER_DEBUG_KMS_THREAD_TYPE" = "user";
  };
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.modesetting.enable = true;
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # use open source version?
  hardware.nvidia.open = false;
}
