user: { ... }: {
  imports = [
    ../x.nix
  ] ++ map (m: (import m user)) [
    ../dunst
    ../rofi
  ];

  services.xserver.windowManager.i3 = {
    enable = true;
    extraPackages = [];
  };
  services.displayManager.defaultSession = "none+i3";
  
  home-manager.users.${user} = { config, pkgs, ... }@inputs: {
    imports = [
      # ./picom.nix
    ];

    xsession.windowManager.i3 = {
      enable = true;
      config = import ./config.nix inputs;
    };

    programs = {
      i3status-rust = {
        enable = true;
        # ...
      };
      i3blocks = {
        enable = true;
        bars = { };
      };
    };

    home.packages = with pkgs; [
      i3lock # default i3 screen locker
      xautolock # lock screen after some time

      # programs.<pkg>.enable will auto install these package
      # i3blocks # status bar
      # i3status-rust # provide information to i3bar
    ];
  };
}
