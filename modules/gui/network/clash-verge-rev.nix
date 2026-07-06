{ sLib, ... }:
(sLib.forLinux.attrs {
  programs.clash-verge = {
    enable = true;
    autoStart = true;
  };
})
// (sLib.forDarwin.attrs {
  homebrew.casks = [
    "clash-verge-rev"
  ];
})
