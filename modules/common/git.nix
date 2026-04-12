{ ... }: {
  home-manager.sharedModules = [
    ({ pkgs, ... }: {
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
    })
  ];
}
