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

    ({ pkgs, ... }: {
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
                  match "^(comics-proxy|kikoeru-proxy|lan-proxy)\.i\.kanakana\.moe\.$"
                  answer "{{ .Name }} 60 IN CNAME nexus.hs.kanakana.moe"
                  fallthrough
              }

              forward . /etc/resolv.conf 223.5.5.5 223.6.6.6 {
                policy sequential
              }
              cache
          }
        '';
      };
      services.nginx = {
        enable = true;

        streamConfig = ''
          server {
            listen 80;
            proxy_pass 192.168.2.3:80;
          }
          server {
            listen 443;
            proxy_pass 192.168.2.3:443;
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
