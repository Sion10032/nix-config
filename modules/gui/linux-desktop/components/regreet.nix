{ config, lib, ... }: {
  config = lib.mkIf config.services.displayManager.regreet.enable {
    services.displayManager.regreet.theme.name = "Adwaita-dark";
  };
}
