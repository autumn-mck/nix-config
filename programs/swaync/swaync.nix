{
  home-manager,
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    swaync.enable = lib.mkEnableOption "swaync";
  };

  config = lib.mkIf (config.swaync.enable) {
    home.packages = with pkgs; [
      libnotify
      swaynotificationcenter
    ];

    xdg.configFile."swaync/config.json".source = ./config.json;
    xdg.configFile."swaync/style.css".source = ./style.css;
  };
}
