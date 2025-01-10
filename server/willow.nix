{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.networking.hostName == "willow") {
    environment.systemPackages = with pkgs; [
    ];

    systemd.services."music-display" = {
      description = "music-display";
      wantedBy = [ "default.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.fish}/bin/fish -c 'cd /home/autumn/MusicDisplayServer && bun dev'";
        Restart = "always";
        WorkingDirectory = "/home/autumn/MusicDisplayServer";
        User = "autumn";
      };
    };

    systemd.services."gnss-mqtt" = {
      description = "gnss-mqtt";
      wantedBy = [ "default.target" ];
      wants = [ "podman.socket" ];
      after = [ "podman.socket" ];
      serviceConfig = {
        ExecStart = "${pkgs.fish}/bin/fish -c 'sleep 1 && cd /home/autumn/mqtt && podman compose up'";
        Restart = "always";
        WorkingDirectory = "/home/autumn/mqtt";
        User = "autumn";
      };
    };

    systemd.services."gnss-war-room" = {
      description = "gnss-war-room";
      wantedBy = [ "default.target" ];
      wants = [ "gnss-mqtt.service" ];
      after = [ "gnss-mqtt.service" ];
      serviceConfig = {
        ExecStart = "${pkgs.fish}/bin/fish -c 'sleep 2 && nix-shell --run \"./webStart.sh\"'";
        Restart = "always";
        WorkingDirectory = "/home/autumn/gnss-war-room";
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
    };
  };
}
