{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Nintendo
    yuzu-mainline
    citra-nightly

    # Retro Games
    retroarch # broken
    # dolphin-emu
    # pcsx2
  ];
}
