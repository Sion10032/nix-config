{ system, lib, ... }: let
  enable = rec {
    value = args: args;
    attrs = value;
    list = value;
    string = value;
    number = value;
  };
  disable = {
    value = args: null;
    attrs = args: {};
    list = args: [];
    string = args: "";
    number = args: 0;
  };
in {
  firstNonNull = values: lib.findFirst
    (v: v != null)
    null
    values;
  firstNonEmptyString = strs: lib.findFirst
    (s: s != "" && s != null)
    ""
    strs;
  firstNonZero = numbers: lib.findFirst
    (num: num != 0)
    0
    numbers;
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
