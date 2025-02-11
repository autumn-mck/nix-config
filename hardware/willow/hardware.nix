{ config, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.initrd.kernelModules = [ "virtio_gpu" ];
  boot.kernelParams = [ "console=tty" ];

  # https://wiki.nixos.org/wiki/Install_NixOS_on_Hetzner_Cloud#Network_configuration
  systemd.network.enable = true;
  systemd.network.networks."10-wan" = {
    matchConfig.Name = "enp1s0"; # either ens3 (amd64) or enp1s0 (arm64)
    networkConfig.DHCP = "ipv4";
    address = [
      # replace this address with the one assigned to your instance
      "2a01:4f8:c013:9be3::/64"
    ];
    routes = [
      { Gateway = "fe80::1"; }
    ];
  };
}
