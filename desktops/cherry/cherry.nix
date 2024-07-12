{ config, lib, ... }:

{
  options = { };

  config = lib.mkIf (config.networking.hostName == "cherry") { };
}

