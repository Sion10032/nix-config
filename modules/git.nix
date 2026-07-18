{ ... }: {
  home-manager.sharedModules = [
    ({ ... }: {
      programs.git = {
        enable = true;

        settings = {
          user = {
            email = "sion10032@hotmail.com";
            name = "sion10032";
          };

          credential = {
            helper = "cache --timeout 3600";
          };
        };
      };

      programs.delta = {
        enable = true;
        enableGitIntegration = true;
        # options = {
        #   side-by-side = true;
        # };
      };
    })
  ];
}
