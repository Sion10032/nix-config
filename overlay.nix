final: prev: let
  overrideIfExists = name: f:
    if prev ? "${name}" then
      { "${name}" = prev."${name}".overrideAttrs f; }
    else
      {};
  replaceIfExists = source: target:
    if prev ? "${source}" then
      { "${source}" = final."${target}"; }
    else
      {};
in {
  misans = final.callPackage ./pkgs/misans.nix {};
}
# // (overrideIfExists "inputplumber" rec {
#   version = "0.79.5";

#   src = prev.fetchFromGitHub {
#     owner = "ShadowBlip";
#     repo = "InputPlumber";
#     tag = "v${version}";
#     hash = "sha256-DZrVYimY0zcs4bZcZBsH6SBREbOpSfi3gXGnuD1VSQA=";
#   };

#   cargoDeps = prev.rustPlatform.fetchCargoVendor {
#     inherit src;
#     hash = "sha256-Wcb9RFgrKwSj9+oyBiyUfHLZ1gxo2HcEh/nBgxYL+yQ=";
#   };
# })
