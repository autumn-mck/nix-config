{
  config,
  pkgs,
  lib,
  ...
}:

{
  options = {
    distrobox.enable = lib.mkEnableOption "distrobox";
  };

  config = lib.mkIf config.distrobox.enable {
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
  };
}
