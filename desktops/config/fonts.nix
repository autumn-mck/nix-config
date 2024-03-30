{ config, lib, pkgs, ... }:

{
  options = { };

  config = {
    fonts = {
      packages = with pkgs; [
        twitter-color-emoji
        (nerdfonts.override { fonts = [ "Mononoki" ]; })
        ibm-plex
        mononoki
      ];

      fontDir.enable = true;

      fontconfig = {
        defaultFonts = {
          sansSerif = [ "IBM Plex Sans" ];
          serif = [ "IBM Plex Serif" ];
          monospace = [ "Mononoki Nerd Font" "IBM Plex Mono" ];
        };
      };
    };
  };
}
