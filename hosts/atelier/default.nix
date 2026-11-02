{
  gui = [ "core" "basic" ];

  modules = [
    (import ../utils/mkNixosPveVm.nix {
      hostName = "atelier";
      disks = {
        efi.uuid = "FDA9-6E51";
        root.uuid = "d2e26f17-f215-4f50-a306-60ec97d88fb3";
        home.uuid = "d25e156c-ca98-4b90-bf5a-a88b639617d9";
      };
    })
    ({ ... }: {
      # Open ports in the firewall.
      networking.firewall.allowedTCPPorts = builtins.genList (x: 5170 + x) 10;
      networking.firewall.allowedUDPPorts = builtins.genList (x: 5170 + x) 10;
    })
    ({ ... }: {
      services.xrdp.defaultWindowManager = "dbus-run-session xfce4-session";
    })
    ({ ... }: {
      home-manager.sharedModules = [
        ({ config, pkgs, lib, ... }: let
          zellij-session-script = pkgs.writeShellScript "zellij-session" ''
            set -u

            SESSION="''${1:?usage: zellij-session <session-name>}"
            ZELLIJ="''${ZELLIJ_BIN:-$(command -v zellij)}"
            POLL=3

            log() { printf '[zellij-session] %s\n' "$*"; }

            session_alive() {
              "$ZELLIJ" list-sessions --no-formatting 2>/dev/null |
                awk -v name="$SESSION" '$1 == name && $0 !~ /EXITED/ { found = 1 } END { exit !found }'
            }

            if session_alive; then
              log "Session '$SESSION' existing"
            else
              log "creating/attaching detached session '$SESSION'"
              "$ZELLIJ" attach --create-background "$SESSION" || { log "create failed"; exit 1; }
            fi

            while sleep "$POLL"; do
              session_alive || break
            done

            log "session '$SESSION' exited; exiting so systemd restarts us"
            exit 0
          '';
        in {
          systemd.user.services.zellij-session-nix = {
            Unit = {
              Description = "Zellij workspace session nix";
            };
            Install.WantedBy = lib.optionals 
              (
                # todo 检测 systemPackages
                builtins.hasAttr "home" config
                  && builtins.elem pkgs.zellij config.home.packages
              )
              [ "default.target" ];
            Service = {
              ExecStart = "${zellij-session-script} nix";
              WorkingDirectory = "%h";
              Restart = "always";
              RestartSec = 3;

              Environment = [
                "TERM=xterm-256color"
                "COLORTERM=truecolor"
              ];
            };
          };
        })
      ];
    })
  ];

  moduleNames = [
    "cli/ai"
    # "cli/ai/pi/pi-web-ui.nix"
    "cli/ai/pi/pi-web.nix"

    "gui/linux-desktop/xfce4.nix"
    "gui/linux-desktop/xrdp.nix"

    "services/builder.nix"
    "services/virtualization/docker.nix"
    "services/zed-remote-server.nix"
    "services/ime.nix"
    # ./modules/gui/linux-desktop/kde.nix
    # (import ./modules/gui/linux-desktop/xrdp.nix "startplasma-x11")
  ];
}
