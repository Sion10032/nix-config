{ pkgs, ... }: {
  home.packages = with pkgs; [
    termscp
  ];
  #home.file.".config/termscp" = {
  #  source = ./config;
  #  recursive = true;
  #};
}
