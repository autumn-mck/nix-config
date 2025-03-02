{
  home-manager,
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    cursor = {
      enable = lib.mkEnableOption "cursor";
    };
  };

  config = lib.mkIf (config.cursor.enable) {
    home.pointerCursor = {
      package = pkgs.catppuccin-cursors.macchiatoMauve;
      name = "catppuccin-macchiato-mauve-cursors";
      # gtk.enable = true; # what does this do compared to the gtk.cursorTheme?
      # x11.enable = true;
      # size = 32;
    };

    gtk.cursorTheme = {
      name = "catppuccin-macchiato-mauve-cursors";
      size = 32;
    };
  };
}
