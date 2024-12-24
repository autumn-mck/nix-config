{ config, lib, ... }:

{
  options = {
    caddy.enable = lib.mkEnableOption "caddy.enable";
  };

  config = lib.mkIf (config.caddy.enable) {
    services.caddy = {
      enable = true;
      email = "caddy@autumn.is";
    };

    networking.firewall.allowedTCPPorts = [
      # http stuff
      80
      443

      # minecraft
      25565

      # mqtt
      1883
      9001
    ];
    networking.firewall.allowedUDPPorts = [
      # minecraft bedrock
      19132
    ];
  };
}
