{ system, lib, ... }: let
  enable = {
    attrs = args: args;
    list = args: args;
    string = args: args;
  };
  disable = {
    attrs = args: {};
    list = args: [];
    string = args: "";
  };
in {
  firstNonEmptyString = strs: lib.findFirst
    (s: s != "" && s != null)
    ""
    strs;
}
// (if (lib.hasSuffix "linux" system) then {
  forDarwin = disable;
  forLinux = enable;
}
else if (lib.hasSuffix "darwin" system) then {
  forDarwin = enable;
  forLinux = disable;
}
else {
  forDarwin = disable;
  forLinux = disable;
})
