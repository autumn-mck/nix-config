{ config, pkgs, lib, ... }:

{
  options = {
    mullvad.enable = lib.mkEnableOption "mullvad";
  };

  config = lib.mkIf (config.mullvad.enable) {
    services.resolved.enable = true;
    services.mullvad-vpn.enable = true;
    services.mullvad-vpn.package = pkgs.mullvad-vpn; # using the gui version
  };
}
