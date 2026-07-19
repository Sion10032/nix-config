{ sLib, ... }:
(sLib.forLinux.attrs {
  programs.clash-verge = {
    enable = true;
    autoStart = true;

    tunMode = true;
    serviceMode = true;
  };

  nixpkgs.overlays = [
    (final: prev: {
      mihomo = prev.mihomo.overrideAttrs (old: {
        version = "1.19.26";

        src = prev.fetchFromGitHub {
          owner = "MetaCubeX";
          repo = "mihomo";
          rev = "v1.19.26";
          hash = "sha256-As0MqIGHs1Gn+aUWpeFsC231n9v7lBNmGlQdAwVWcJs=";
        };

        vendorHash = "sha256-ySpBMR/djPPs1aTw7yiCrCFxDFsvRfTJEChg8v1C408=";
      });
    })
  ];
})
// (sLib.forDarwin.attrs {
  homebrew.casks = [
    "clash-verge-rev"
  ];
})
