let
  # inherit (builtins) toString;
  # inherit (import <nixpkgs/lib>) removePrefix;

  # machine-settings = import ../machine-settings.nix;
  # userPath = ../../home + "/${machine-settings.user}";
  # # userPath = "";
  # userPathStr = toString userPath;
in
map (f:
  let
    # fStr = toString f;
    # relative = removePrefix userPathStr fStr;
    # # relative = fStr;
  in
    # builtins.trace "userPath: ${userPathStr}"
    # builtins.trace "f       : ${fStr}"
    # ../../modules/home + relative
    f
)
