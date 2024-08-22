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

    networking.firewall.allowedTCPPorts = [ 80 443 25565 ];
    networking.firewall.allowedUDPPorts = [ 19132 ];
  };
}
