{ ... }: {
  home-manager.sharedModules = [
    ({ pkgs, ... }: {
      services.podman = {
        enable = true;
      };

      home.packages = with pkgs; [
        podman-compose
      ];
    })
  ];
}
