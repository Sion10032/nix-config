{ pkgs, config, ... }: {
  home.packages = with pkgs; [
    termscp
  ];

  # xdg.configFile."termscp".source = config.lib.file.mkOutOfStoreSymlink ./config;

  #home.file.".config/termscp" = {
  #  source = ./config;
  #  recursive = true;
  #};
}
