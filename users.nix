{ config, lib, pkgs, ... }: {
  users.users.sion = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.fish;
  };
}

