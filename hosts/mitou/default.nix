{
  modules = [
    (import ../utils/mkNixosPveVm.nix {
      hostName = "mitou";
      disks = {
        efi.uuid = "123C-A103";
        root.uuid = "d391dd2e-579a-4768-aa1e-effd0d49e671";
        home.uuid = "a9c67982-104b-4f67-9152-9779f3fb45d8";
      };
    })
  ];

  moduleNames = [
    # ./modules/hardware.nix
    # ./modules/linux-dektop
  ];
}
