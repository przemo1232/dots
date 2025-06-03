let
  inherit (builtins) toString;
  inherit (import <nixpkgs/lib>) removePrefix;

  machine-settings = import ../machine-settings.nix;
  userPath = "/etc/nixos/system/${machine-settings.user}";
in
map (f:
  ../../modules/system + (removePrefix userPath (toString f))
)
