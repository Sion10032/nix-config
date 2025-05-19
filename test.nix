user: { pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    neovim
  ];

  home-manager.users.${user} = { pkgs, ... }: {
    home.packages = with pkgs; [
      zsh
    ];
  };
}
