{ config, lib, ... }:

{
  options = { };

  config = lib.mkIf (config.networking.hostName == "cherry") {
    networking.networkmanager.enable = true;
    users.users.autumn.extraGroups = [ "networkmanager" ];
  };
}

