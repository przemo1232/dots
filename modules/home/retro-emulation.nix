{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Nintendo
    yuzu-mainline
    citra-nightly

    # Retro Games
    retroarch
    # dolphin-emu
    # pcsx2
  ];
}
