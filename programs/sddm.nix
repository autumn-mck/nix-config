{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    sddm.enable = lib.mkEnableOption "sddm";
  };

  config = lib.mkIf config.sddm.enable {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "sddm-astronaut-theme";
    };

    services.displayManager.defaultSession = "hyprland";

    environment.systemPackages = with pkgs; [
      (catppuccin-sddm.override {
        flavor = "macchiato";
        font = "IBM Plex Sans";
        fontSize = "16";
      })

      pixel-code
      (sddm-astronaut.override {
        embeddedTheme = "purple_leaves";
      })
      kdePackages.qtmultimedia
    ];
  };
}
