{ pkgs, ... }:

{
  # make stuff work on wayland
  environment.variables = {
    _JAVA_AWT_WM_NONREPARENTING = "1";
    MOZ_ENABLE_WAYLAND = "1";
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
    LIBVA_DRIVER_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  hardware.sensor.iio.enable = true;
  # services.udev.extraHwdb = ''
  #   sensor:modalias:acpi:INVN6500*:dmi:*svn*ASUSTeK*:*pn*TP300LA*
  #    ACCEL_MOUNT_MATRIX=0, 1, 0; 1, 0, 0; 0, 0, 1
  # '';

  
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    xorg.libX11
    xorg.libXcursor
    xorg.libxcb
    xorg.libXi
    libxkbcommon
  ];
  
  environment.systemPackages = with pkgs; [
    wayland
    egl-wayland
    mako
    libnotify
    wlr-randr
    wdisplays
    wofi
    wofi-emoji
    jq
    swayidle
    wl-clipboard
    libsForQt5.qt5.qtwayland
    libsForQt5.polkit-kde-agent
    libsForQt5.qt5ct
    libva
  ];

  # Enable polkit
  security.polkit.enable = true;
}
