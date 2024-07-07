{ config, pkgs, lib, ... }:

{
  options = {
    hyprlock.enable = lib.mkEnableOption "hyprlock";
  };

  config = lib.mkIf (config.hyprlock.enable) {
    security.pam.services.swaylock = { };
    security.polkit.enable = true;

    environment.systemPackages = with pkgs; [
      hyprlock
    ];
  };
}
