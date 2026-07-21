{ pkgs, sLib, ... }:let
  fonts = with pkgs; [
    misans
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    maple-mono.Normal-NF-CN
  ];
in
{
  environment.systemPackages = fonts;
}
// sLib.forLinux.attrs {
  fonts.packages = fonts;
  fonts.fontconfig.defaultFonts = {
    sansSerif = [
      "MiSans"
      "Noto Sans CJK SC"
    ];

    serif = [
      "Noto Serif CJK SC"
    ];

    monospace = [
      "Maple Mono Normal NF CN"
    ];
  };

  system.userActivationScripts.linktosharedfolder.text = ''
		if [[ ! -h "$HOME/.local/share/fonts" ]]; then
		 ln -s "/run/current-system/sw/share/fonts" "$HOME/.local/share/fonts"
		fi
	'';

  home-manager.sharedModules = [
    ({ ... }: {
      fonts.fontconfig.enable = false;
    })
  ];
}
