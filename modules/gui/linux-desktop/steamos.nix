{ inputs, pkgs, sLib, ... }: sLib.forLinux.attrs {
  imports = [
    inputs.jovian.nixosModules.default
    ./kde.nix
  ];
  jovian.steam = {
    enable = true;
    autoStart = true;
    user = "sion";
    desktopSession = "plasma";
  };
  jovian.hardware.has.amd.gpu = true;

  systemd.user.services.steam-language-setup = {
    description = "Setup Steam language";
    before = [ "graphical-session.target" ];
    wantedBy = [ "graphical-session.target" ];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = pkgs.writeShellScript "steam-language-setup" ''
        config="$HOME/.steam/registry.vdf"

        if [ ! -f "$config" ]; then
          echo "[steam-language] config not found."
          exit 0
        fi

        if grep -qE '"language"[[:space:]]+"[^"]+"' "$config"; then
          ${pkgs.gnused}/bin/sed -i -E 's/("language"[[:space:]]+")[^"]+(")/\1schinese\2/' "$config"
          echo "[steam-language] language changed to schinese."
        else
          echo "[steam-language] language entry not found."
        fi
      '';
    };
  };
}
