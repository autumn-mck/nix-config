{
  config,
  nixos-hardware,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    nixos-hardware.nixosModules.framework-13-7040-amd
    ./hardware-configuration.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  services.fwupd.enable = true;

  # only for installing an unsigned beta firmware (eg. 3.03b), not generally needed
  # environment.etc."fwupd/daemon.conf".text = lib.mkForce ''
  #   [fwupd]
  #   DisabledPlugins=test;test_ble
  #   IdleTimeout=7200
  #   IgnorePower=false
  #   ShowDevicePrivate=true
  #   AllowEmulation=false
  #   OnlyTrusted=false
  # '';

  # we need fwupd 1.9.7 to downgrade the fingerprint sensor firmware
  # (from https://github.com/NixOS/nixos-hardware/tree/master/framework/13-inch/7040-amd#getting-the-fingerprint-sensor-to-work)
  services.fwupd.package =
    (import
      (builtins.fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/bb2009ca185d97813e75736c2b8d1d8bb81bde05.tar.gz";
        sha256 = "sha256:003qcrsq5g5lggfrpq31gcvj82lb065xvr7bpfa8ddsw8x4dnysk";
      })
      {
        inherit (pkgs) system;
      }
    ).fwupd;

  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };

  console.keyMap = "uk";
}
