{ home-manager, lib, config, ... }:

{
  options = {
    kitty = {
      enable = lib.mkEnableOption "kitty";
      defaultShell = lib.mkOption {
        type = lib.types.str;
        default = "fish";
      };
    };
  };

  config = lib.mkIf config.kitty.enable {
    programs.kitty = {
      enable = true;
      theme = "Catppuccin-Macchiato";
      environment = {
        "SHELL" = config.kitty.defaultShell;
      };

      settings = {
        background_opacity = "0.8";
        shell = config.kitty.defaultShell;
      };
    };
  };
}
