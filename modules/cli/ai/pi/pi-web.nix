{ inputs, ... }: let
  port = 30141;
in {
  networking.firewall.allowedTCPPorts = [ port ];
  home-manager.sharedModules = [
    inputs.pi-web-ui.homeManagerModules.pi-web
    ({ ... }: {
      services.pi-web = {
        enable = true;
        host = "0.0.0.0";
        inherit port;
        allowedHosts = [
          "pi.i.kanakana.moe"
          "192.168.2.12"
          "localhost"
        ];
        extraArgs = [
          "--no-open"
        ];
      };
    })
  ];
}