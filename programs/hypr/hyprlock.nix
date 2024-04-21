{ config, pkgs, ... }:

{
  security.pam.services.swaylock = { };
  security.polkit.enable = true;

  environment.systemPackages = with pkgs; [
    hyprlock
  ];
}
