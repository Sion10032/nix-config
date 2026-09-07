{ lib, config, pkgs, ... }: let
  gvfsConfig = {
    services.gvfs = {
      enable = true;
      package =
        if config.services.gnome.core-shell.enable then
          pkgs.gnome.gvfs
        else
          pkgs.gvfs;
    };
  };
in {
  options = {
    programs.nemo.enable = lib.mkEnableOption "nemo";
  };

  config = lib.mkMerge [
    (lib.mkIf config.programs.nemo.enable {
      environment.systemPackages = with pkgs; [
        nemo
        ffmpegthumbnailer
      ];

    } // gvfsConfig)
    (lib.mkIf config.programs.thunar.enable gvfsConfig)
  ];
}