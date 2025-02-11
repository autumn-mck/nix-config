{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    bluetooth.enable = lib.mkEnableOption "bluetooth";
  };

  config = lib.mkIf config.bluetooth.enable {
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;

    environment.systemPackages = with pkgs; [
      blueman
    ];
  };
}
