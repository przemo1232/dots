user:

let
  inherit (builtins) toString;
  inherit (import <nixpkgs/lib>) removePrefix;

  userPath = ../../home + "/${user}";
  userPathStr = toString userPath;
in
map (f:
  let
    fStr = toString f;
    relative = removePrefix userPathStr fStr;
  in
    # builtins.trace "userPath: ${userPathStr}"
    # builtins.trace "f       : ${fStr}"
    ../../modules/home + relative
)
