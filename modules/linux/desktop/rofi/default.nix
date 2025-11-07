{ config, lib, ... }: let 
  cfg = config.kana.programs.rofi;
in {
  options = {
    kana.programs.rofi = {
      enable = lib.mkEnableOption "rofi";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.sharedModules = [
      ({ pkgs, ... }@inputs: {
        programs.rofi = {
          enable = true;
          # package = pkgs.rofi-wayland;
        };
      })
    ];
  };
}