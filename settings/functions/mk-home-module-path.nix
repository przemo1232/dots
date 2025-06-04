user: lib:

let
  inherit (builtins) toString;

  userPath = ../../home + "/${user}";
  userPathStr = toString userPath;
in
map (f:
  let
    fStr = toString f;
    relative = lib.removePrefix userPathStr fStr;
  in
    # builtins.trace "userPath: ${userPathStr}"
    # builtins.trace "f       : ${fStr}"
    ../../modules/home + relative
)
