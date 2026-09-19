{ inputs, ... }: let
  port = 38787;
in {
  networking.firewall.allowedTCPPorts = [ port ];
  home-manager.sharedModules = [
    inputs.pi-web-ui.homeManagerModules.default
    ({ ... }: {
      services.pi-web-ui = {
        enable = true;
        host = "0.0.0.0";
        inherit port;
        allowOrigins = [
          "https://pi.i.kanakana.moe"
        ];
        extraArgs = [
          "--no-browser"
        ];
      };
    })
  ];
}