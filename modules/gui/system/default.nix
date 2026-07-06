{ sLib, ... }:
(sLib.forDarwin.attrs {
  homebrew.casks = [
    "stats"
    "karabiner-elements"
  ];
})
