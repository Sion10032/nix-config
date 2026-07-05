{ config, lib, ... }: let 
  cfg = config.kana.programs.dunst;
in {
  options = {
    kana.programs.dunst = {
      enable = lib.mkEnableOption "dunst";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.sharedModules = [
      ({ config, pkgs, ... }@inputs: {
        services.dunst = {
          enable = true;
        };
      })
    ];
  };
}