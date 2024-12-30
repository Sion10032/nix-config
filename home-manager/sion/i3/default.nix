{ config, pkgs, ... }@inputs: {
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
    rofi # application launcher, the same as dmenu
    dunst # notification daemon
    i3lock # default i3 screen locker
    xautolock # lock screen after some time

    # programs.<pkg>.enable will auto install these package
    # i3blocks # status bar
    # i3status-rust # provide information to i3bar
  ];
}
