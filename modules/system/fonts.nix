{ pkgs, inputs, ... }:

{
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-extra
      noto-fonts-emoji
      noto-fonts-emoji-blob-bin
      ipafont
    ];
    # ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts); # all nerd fonts
  };
}
