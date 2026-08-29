{ sLib, pkgs, ... }:let
  fonts = with pkgs; [
    misans
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    maple-mono.Normal-NF-CN
  ];
in
{
  environment.systemPackages = fonts;
  fonts = {
    packages = fonts;
  }
  // sLib.forLinux.attrs {
    fontDir.enable = true;

    fontconfig.defaultFonts = {
      sansSerif = [
        "MiSans"
        "Noto Sans CJK SC"
      ];

      serif = [
        "MiSans"
        "Noto Sans CJK SC"
        "Noto Serif CJK SC"
      ];

      monospace = [
        "Maple Mono Normal NF CN"
      ];
    };
  };
}
// sLib.forLinux.attrs {
  system.userActivationScripts.linktosharedfolder.text = ''
		if [[ ! -h "$HOME/.local/share/fonts" ]]; then
		 ln -s "/run/current-system/sw/share/X11/fonts" "$HOME/.local/share/fonts"
		fi
	'';

  home-manager.sharedModules = [
    ({ ... }: {
      fonts.fontconfig.enable = false;
    })
  ];
}
