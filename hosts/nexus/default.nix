{
  modules = [
    (import ../utils/mkNixosPveVm.nix {
      hostName = "nexus";
      disks = {
        efi.uuid      = "9F56-0140";
        root.uuid     = "40b5e17f-c395-429e-83b7-180bd356b9e4";
        home.uuid     = "9414659c-f532-40c1-9411-6e141c730a0e";
        persist.uuid  = "3659cae4-6152-4c18-a329-539a608c8ed5";
      };
    })

    ({ lib, pkgs, ... }: let
      domains = lib.concatStringsSep "|" [
        "comics-proxy"
        "kikoeru-proxy"
        "lan-proxy"
        "firefox"
        "qq"
        "wechat"
        "pi"
      ];
    in {
      services.tailscale.enable = true;
      systemd.services.tailscaled = {
        serviceConfig.ExecStart = [
          ""
          "${pkgs.tailscale}/bin/tailscaled --statedir=/persist/tailscale/ --socket=/run/tailscale/tailscaled.sock --port=\${PORT} $FLAGS"
        ];
      };

      services.coredns = {
        enable = true;
        config = ''
          .:53 {
              template IN ANY kanakana.moe {
                  match "^(${domains})\.i\.kanakana\.moe\.$"
                  answer "{{ .Name }} 60 IN CNAME nexus.hs.kanakana.moe"
                  fallthrough
              }

              forward . /etc/resolv.conf 223.5.5.5 223.6.6.6 {
                policy sequential
              }

              cache {
                  success 4096 300
                  denial 512 5
              }
          }
        '';
      };
      services.nginx = {
        enable = true;

        streamConfig = ''
          server {
            listen 443;
            proxy_pass 192.168.2.3:443;
          }

          # rdp forward
          # island
          server {
            listen 33810;
            proxy_pass 192.168.2.10:3389;
          }
          # windows-dev
          server {
            listen 33811;
            proxy_pass 192.168.2.11:3389;
          }
          # atelier
          server {
            listen 33812;
            proxy_pass 192.168.2.12:3389;
          }
        '';

        # recommendedTlsSettings = true;
        # recommendedGzipSettings = true;
        # recommendedProxySettings = true;
        # recommendedOptimisation = true;
      };
    })
  ];
}
