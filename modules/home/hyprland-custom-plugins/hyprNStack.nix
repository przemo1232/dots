{
  lib,
  fetchFromGitHub,
  cmake,
  hyprland,
  hyprlandPlugins,
  pkgs,
  ...
}:
hyprlandPlugins.mkHyprlandPlugin hyprland {
  pluginName = "hyprNStack";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "zakk4223";
    repo = "hyprNStack";
    rev = "1959ecbc50071e5e182b6ce0edff92245870caf1";
    hash = "sha256-LL1+gGBQcb+P0hiCGhHKDIhy7+UqwUBmU+kh0YQTYI0=";
  };

  nativeBuildInputs = with pkgs; [ pkg-config pixman libdrm ];

  buildInputs = [];

  installPhase = ''
    runHook preInstall
    mkdir -p $out/lib
    cp nstackLayoutPlugin.so $out/lib/
    runHook postInstall
  '';

  meta = {
    homepage = "https://github.com/zakk4223/hyprNStack";
    description = "Hyprland plugin for N-stack tiling layout";
    license = lib.licenses.bsd3;
    platforms = lib.platforms.linux;
  };
}
