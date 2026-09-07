{ sLib, lib, pkgs, ... }: {
  imports = [
    ../components
    ./noctalia.nix
  ];

  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  programs.nemo.enable = true;

  environment.systemPackages = with pkgs; [
    adw-gtk3
    mission-center
    brightnessctl
  ];

  # todo use uwsm https://wiki.hyprland.org/Useful-Utilities/Systemd-start/

  home-manager.sharedModules = [
    ({ ... }: {
      wayland.windowManager.hyprland.enable = true;
      wayland.windowManager.hyprland.settings = import ./settings.nix { inherit sLib lib; };
      # xdg.configFile."hypr/hyprland.lua".source = ./hyprland.lua;

      services.hyprpolkitagent.enable = true;
      # services.hyprpaper = {
      #   enable = true;
      #   settings = {
      #     ipc = "on";
      #     # splash = false;
      #     # splash_offset = 2.0;
      #   };
      # };
    })
  ];
}