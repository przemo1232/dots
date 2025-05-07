{ pkgs, pkgs2405, ... }:

{
  home.packages = with pkgs; [
    torzu # Switch
    cemu # Wii U

    # Retro Games
    (pkgs.retroarch.withCores (cores: with cores; [
      mupen64plus # Ninetndo 64
      dolphin # Game Cube
      citra # 3ds
    ]))
    # dolphin-emu
    # pcsx2
  ];
}
