{
  gui = true;

  modules = [
    ({ ... }: {
      # Set Git commit hash for darwin-version.
      # system.configurationRevision = self.rev or self.dirtyRev or null;

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
  ];

  moduleNames = [
    "cli/ai"

    "gui/system"
    "gui/network/clash-verge-rev.nix"
  ];
}
