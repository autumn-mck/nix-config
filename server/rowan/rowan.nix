{ config, ... }:

{
  imports = [
    ./caddy.nix
  ];

  environment.systemPackages = with pkgs; [
    bun
  ];
}
