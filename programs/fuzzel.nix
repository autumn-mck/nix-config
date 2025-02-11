{
  home-manager,
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    fuzzel.enable = lib.mkEnableOption "fuzzel";
  };

  config = lib.mkIf config.fuzzel.enable {
    programs.fuzzel = {
      enable = true;
      settings = {
        main = {
          icon-theme = "Papirus-Dark";
          horizontal-pad = 30;
          vertical-pad = 10;
        };

        colors = {
          background = "24273add";
          text = "cad3f5ff";
          match = "c6a0f6ff";
          selection = "181926dd";
          selection-text = "cad3f5ff";
          border = "181926ff";
        };

        border.width = 2;
      };
    };
  };
}
