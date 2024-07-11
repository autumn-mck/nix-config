{ config, lib, pkgs, ... }:

{
  options = {
    sddm.enable = lib.mkEnableOption "sddm";
  };

  config = lib.mkIf config.sddm.enable {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "catppuccin-macchiato";
      package = pkgs.kdePackages.sddm;
    };

    environment.systemPackages = with pkgs; [
      (catppuccin-sddm.override {
        flavor = "macchiato";
        font = "IBM Plex Sans";
        fontSize = "16";
      })
    ];
  };
}
