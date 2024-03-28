{ home-manager, pkgs, ... }:

{
  home.packages = with pkgs; [
    libnotify
    swaynotificationcenter
  ];

  xdg.configFile."swaync/config.json".source = ./config.json;
  xdg.configFile."swaync/style.css".source = ./style.css;
}
