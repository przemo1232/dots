let
  inherit (builtins) toString;
  inherit (import <nixpkgs/lib>) removePrefix;

  machine-settings = import ../machine-settings.nix;
  userPath = "/etc/nixos/home/${machine-settings.user}";
in
map (f:
  ../../modules/home + (removePrefix userPath (toString f))
)
