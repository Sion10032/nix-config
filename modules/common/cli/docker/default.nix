{ lib, users, ... }: let
  getUserConfig = user: {
    users.users."${user}".extraGroups = [ "docker" ];
  };
in {
  virtualisation.docker = {
    enable = true;

    daemon.settings = {

    };
  };
} // lib.mergeAttrsList (lib.map getUserConfig users)
