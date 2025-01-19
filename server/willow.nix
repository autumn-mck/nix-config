{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.networking.hostName == "willow") {
    environment.systemPackages = with pkgs; [
    ];

    systemd.services."music-display" = {
      description = "music-display";
      wantedBy = [ "default.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.fish}/bin/fish -c 'bun dev'";
        Restart = "always";
        WorkingDirectory = "/home/autumn/MusicDisplayServer";
        User = "autumn";
      };
    };

    systemd.services."gnss-mqtt" = {
      description = "gnss-mqtt";
      wantedBy = [ "default.target" ];
      requires = [ "podman.socket" ];
      after = [ "podman.socket" ];
      serviceConfig = {
        ExecStart = "${pkgs.fish}/bin/fish -c 'cd /home/autumn/mqtt && podman compose up'";
        Restart = "always";
        RestartSec = "3s";
        WorkingDirectory = "/home/autumn/mqtt";
        User = "autumn";
      };
    };

    systemd.services."gnss-war-room" = {
      description = "gnss-war-room";
      wantedBy = [ "default.target" ];
      requires = [ "gnss-mqtt.service" ];
      after = [ "gnss-mqtt.service" ];
      serviceConfig = {
        ExecStart = "${pkgs.fish}/bin/fish -c 'nix-shell --run \"./webStart.sh\"'";
        Restart = "always";
        RestartSec = "5s";
        WorkingDirectory = "/home/autumn/gnss-war-room";
        User = "autumn";
      };
    };

    systemd.services."wopr" = {
      description = "wopr";
      wantedBy = [ "default.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.fish}/bin/fish -c 'nix-shell --run \"./startup.sh\"'";
        Restart = "always";
        RestartSec = "5s";
        WorkingDirectory = "/home/autumn/wopr";
        User = "autumn";
      };
    };

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


      virtualHosts."gnss.autumn.is" = {
        extraConfig = ''
          reverse_proxy localhost:2024
        '';
      };
    };
  };
}
