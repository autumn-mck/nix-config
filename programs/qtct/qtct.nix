{ home-manager, pkgs, ... }:

{
  home.packages = with pkgs; [
    qt5ct
    qt6ct
  ];

  qt.enable = true;
  qt.platformTheme = "qtct";

  xdg.configFile."qt5ct/qt5ct.conf".source = ./qt5ct.conf;
  xdg.configFile."qt6ct/qt6ct.conf".source = ./qt6ct.conf;
  xdg.configFile."qt5ct/colors/Catppuccin-Macchiato.conf".source = ./Catppuccin-Macchiato.conf;
  xdg.configFile."qt6ct/colors/Catppuccin-Macchiato.conf".source = ./Catppuccin-Macchiato.conf;
}
