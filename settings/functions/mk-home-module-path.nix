user:

let
  inherit (builtins) toString;

  removePrefix = prefix: str:
    if builtins.substring 0 (builtins.stringLength prefix) str == prefix
    then builtins.substring (builtins.stringLength prefix) (builtins.stringLength str - builtins.stringLength prefix) str
    else throw "removePrefix: '${prefix}' is not a prefix of '${str}'";


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
