{ config, lib, ... }: let 
  cfg = config.kana.programs.eww;
in {
  options = {
    kana.programs.eww = {
      enable = lib.mkEnableOption "eww";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.sharedModules = [
      ({ config, pkgs, ... }@inputs: {
        programs.eww = {
          enable = true;
        };
      })
    ];
  };
}