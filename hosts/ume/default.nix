{
  modules = [
    ({ ... }: {
      # Set Git commit hash for darwin-version.
      # system.configurationRevision = self.rev or self.dirtyRev or null;

      networking.hostName = "ume";

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    })
    ({ ... }: {
      users.knownUsers = [ "sion" ];
      users.users.sion.uid = 501;
    })
    ({ ... }: {
      homebrew.brews = [
        "localai"
      ];
      homebrew.casks = [
        "crisp"
        "rustdesk"
        "stats"
        "zcode"
      ];
    })
  ];

  moduleNames = [
    "cli/ai"
    # "cli/virtualization/lima.nix"

    "services/builder.nix"
    "services/zed-remote-server.nix"
  ];
}
