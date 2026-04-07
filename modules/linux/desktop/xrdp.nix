defaultSession: { config, lib, ... }: {
  services.xrdp = {
    enable = true;
    audio.enable = true;
    openFirewall = true;
    defaultWindowManager = defaultSession;
  };
}
