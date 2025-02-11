{
  home-manager,
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    qtct.enable = lib.mkEnableOption "qtct";
  };

  config = lib.mkIf (config.qtct.enable) {
    home.packages = with pkgs; [
      libsForQt5.qt5ct
      qt6ct
    ];

    qt.enable = true;

    xdg.configFile."qt5ct/qt5ct.conf".source = ./qt5ct.conf;
    xdg.configFile."qt6ct/qt6ct.conf".source = ./qt6ct.conf;
    xdg.configFile."qt5ct/colors/Catppuccin-Macchiato.conf".source = ./Catppuccin-Macchiato.conf;
    xdg.configFile."qt6ct/colors/Catppuccin-Macchiato.conf".source = ./Catppuccin-Macchiato.conf;
  };
}
