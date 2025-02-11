{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = { };

  config = lib.mkIf (config.isDesktop) {
    fonts = {
      packages = with pkgs; [
        twitter-color-emoji
        nerd-fonts.mononoki
        ibm-plex
        mononoki
        vistafonts
      ];

      fontDir.enable = true;

      fontconfig = {
        defaultFonts = {
          sansSerif = [ "IBM Plex Sans" ];
          serif = [ "IBM Plex Serif" ];
          monospace = [
            "Mononoki Nerd Font"
            "IBM Plex Mono"
          ];
        };
      };
    };
  };
}
