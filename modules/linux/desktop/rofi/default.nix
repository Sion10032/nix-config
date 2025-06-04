user: { ... }: {
  home-manager.users.${user} = { config, lib, pkgs, ... }@inputs: {
    programs.rofi = {
      enable = true;
      # need a better way to define module, cause now if package is set, i will get
      # 'The option `programs.rofi.package' is defined multiple times while it's expected to be unique'.
      # package = pkgs.rofi-wayland;
    };
  };
}