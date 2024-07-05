{ home-manager, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    waybar
  ];

  xdg.configFile."waybar/config.jsonc".source = ./config.jsonc;
  xdg.configFile."waybar/style.css".source = ./style.css;
}
