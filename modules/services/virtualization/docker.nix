{ lib, sUsers, ... }: let
  getUserConfig = user: {
    users.users."${user}".extraGroups = [ "docker" ];
  };
in {
  virtualisation.docker = {
    enable = true;
  };
} // lib.mergeAttrsList (lib.map getUserConfig sUsers)
