{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.networking.hostName == "rowan") {
    environment.systemPackages = with pkgs; [
    ];

    caddy.enable = true;
    forgejo.enable = true;
    services.caddy = {
      virtualHosts."music-display.autumn.is" = {
        extraConfig = ''
          encode gzip
          reverse_proxy localhost:3000
        '';
      };

      virtualHosts."music-display.mck.is" = {
        extraConfig = ''
          encode gzip
          reverse_proxy localhost:3000
        '';
      };

      virtualHosts."http://music-display.mck.is" = {
        extraConfig = ''
          encode gzip
          reverse_proxy localhost:3000
        '';
      };


      virtualHosts."gnss-mqtt.mck.is" = {
        extraConfig = ''
          reverse_proxy localhost:1883
        '';
      };

      virtualHosts."wopr.mck.is" = {
        extraConfig = ''
          reverse_proxy localhost:1983
        '';
      };

      virtualHosts."gnss.mck.is" = {
        extraConfig = ''
          reverse_proxy localhost:2024
        '';
      };
    };
  };
}
