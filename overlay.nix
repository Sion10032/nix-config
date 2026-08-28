final: prev: let
  overrideIfExists = name: f:
    if prev ? "${name}" then
      { "${name}" = prev."${name}".overrideAttrs f; }
    else
      {};
in {
  misans = final.callPackage ./pkgs/misans.nix {};
}
