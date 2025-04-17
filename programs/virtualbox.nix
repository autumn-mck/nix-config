{
  config,
  home-manager,
  pkgs,
  lib,
  ...
}:

{
  options = {
    virtualbox.enable = lib.mkEnableOption "virtualbox.enable";
  };

  config = lib.mkIf (config.virtualbox.enable) {
    virtualisation.virtualbox.host.enable = true;
    users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];

    # virtualisation.virtualbox.guest.enable = true;
    # virtualisation.virtualbox.guest.dragAndDrop = true;
  };
}
