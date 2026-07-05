{ sLib, ... }:
sLib.forLinux.attrs {
  hardware.opentabletdriver = {
    enable = true;
  };
}