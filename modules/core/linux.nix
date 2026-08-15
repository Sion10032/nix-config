{ sLib, ... }: sLib.forLinux.attrs {
  networking.firewall.enable = true;

  # Run unpatched dynamic binaries on NixOS.
  programs.nix-ld.enable = true;

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocales = [
      "zh_CN.UTF-8/UTF-8"
    ];
  };
}
