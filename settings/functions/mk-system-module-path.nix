let
  inherit (builtins) toString;
  inherit (import <nixpkgs/lib>) removePrefix;

  machine-settings = import ../machine-settings.nix;
  userPath = ../../system + "/${machine-settings.user}";
  userPathStr = toString userPath;
in
map (f:
  let
    fStr = toString f;
    relative = removePrefix userPathStr fStr;
  in
    builtins.trace "userPath: ${userPathStr}"
    builtins.trace "f       : ${fStr}"
    ../../modules/system + relative
)
