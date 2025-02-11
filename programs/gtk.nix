{
  home-manager,
  pkgs,
  config,
  lib,
  ...
}:

{
  options = {
    gtkTheming.enable = lib.mkEnableOption "gtkTheming";
  };

  config = lib.mkIf config.gtkTheming.enable {
    gtk = {
      enable = true;
      theme = {
        name = "catppuccin-macchiato-mauve-compact+rimless,normal";
        package = pkgs.catppuccin-gtk.override {
          accents = [ "mauve" ];
          size = "compact";
          tweaks = [
            "rimless"
            "normal"
          ];
          variant = "macchiato";
        };
      };
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.catppuccin-papirus-folders.override {
          accent = "mauve";
          flavor = "macchiato";
        };
      };
    };

    xdg = {
      enable = true;

      configFile = {
        "gtk-4.0/assets".source =
          "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
        "gtk-4.0/gtk.css".source =
          "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
        "gtk-4.0/gtk-dark.css".source =
          "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
      };
    };
  };
}
