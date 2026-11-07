{ inputs, ... }: let
  port = 38787;
in {
  networking.firewall.allowedTCPPorts = [ port ];
  home-manager.sharedModules = [
    inputs.pi-web-ui.homeManagerModules.pi-web-ui
    ({ ... }: {
      services.pi-web-ui = {
        enable = true;
        host = "0.0.0.0";
        inherit port;
        allowHosts = [
          "pi.i.kanae.cc"
          "192.168.2.12"
          "localhost"
        ];
        extraArgs = [
          "--no-browser"
        ];
      };
    })
  ];
}