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
          reverse_proxy localhost:3000
        '';
      };

      virtualHosts."music-display.mck.is" = {
        extraConfig = ''
          reverse_proxy localhost:3000
        '';
      };

      virtualHosts."http://music-display.mck.is" = {
        extraConfig = ''
          reverse_proxy localhost:3000
        '';
      };
    };
  };
}