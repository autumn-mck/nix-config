{ home-manager, pkgs, lib, config, ... }:

{
  options = {
    waybar.enable = lib.mkEnableOption "waybar";
  };

  config = lib.mkIf (config.waybar.enable) {
    home.packages = with pkgs; [
      waybar
    ];

    xdg.configFile."waybar/config.jsonc".source = ./config.jsonc;
    xdg.configFile."waybar/style.css".source = ./style.css;
  };
}
