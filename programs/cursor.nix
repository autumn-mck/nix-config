{ home-manager, pkgs, lib, config, ... }:

{
  options = {
    cursor = {
      enable = lib.mkEnableOption "cursor";
    };
  };

  config = lib.mkIf (config.cursor.enable) {
    home.pointerCursor = {
      package = pkgs.catppuccin-cursors.macchiatoMauve;
      name = "Catppuccin-Macchiato-Mauve-Cursors";
      #gtk.enable = true; # what does this do compared to the gtk.cursorTheme?
      size = 48;
    };

    gtk.cursorTheme = {
      name = "Catppuccin-Macchiato-Mauve-Cursors";
      size = 48;
    };
  };
}
