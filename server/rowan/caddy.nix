{ config, ... }:

{
  services.caddy = {
    enable = true;
    email = "caddy@autumn.is";
    virtualHosts."localhost".extraConfig = ''
      respond "Hello, world!"
    '';

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
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
