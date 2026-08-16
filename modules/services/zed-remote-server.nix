{ ... }: {
  home-manager.sharedModules = [
    ({ pkgs, ... }: {
      home.packages = with pkgs; [
        zed-editor.remote_server
      ];

      home.file.".zed_server" = {
        source = "${pkgs.zed-editor.remote_server}/bin";
        recursive = true;
      };
    })
  ];
}
