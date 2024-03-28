{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    distrobox
    boxbuddy
  ];

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };
}
