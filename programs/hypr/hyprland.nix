{
  config,
  lib,
  pkgs,
  ...
}:

# stuff for hyprland

{
  imports = [
    ./hyprlock.nix
  ];

  options = {
    hyprland.enable = lib.mkEnableOption "hyprland";
  };

  config = lib.mkIf (config.hyprland.enable) {
    programs.hyprland.enable = true;
    hyprlock.enable = true;

    # TODO set up hyprshade

    # packages for WM stuff
    environment.systemPackages = with pkgs; [
      hyprshade

      grim
      slurp
      swappy
      wl-clipboard

      bemoji
      cliphist
      wl-clip-persist

      hyprpaper

      lxqt.lxqt-policykit

      kdePackages.dolphin # kde6 version seems to run through xwayland for some reason, kde5 version is fine for now
      kdePackages.ark

      lightly-boehs

      kdePackages.gwenview

      hyprnome
      hyprland-autoname-workspaces
    ];

    qt = {
      enable = true;
      platformTheme = "kde";
      style = "breeze";
    };

    home-manager.users.autumn = {
      qt = {
        style.name = "Catppuccin-Macchiato-Mauve";
        style.package = pkgs.catppuccin-kde;
      };

      xdg.configFile."hypr/macchiato.conf".source = ./macchiato.conf;
      xdg.configFile."hypr/scripts/screenshot.sh".source = ./screenshot.sh;

      xdg.configFile."hyprland-autoname-workspaces/config.toml".source = ./autoname.toml;

      xdg.configFile."hypr/hyprpaper.conf".source = ./hyprpaper.conf;
      xdg.configFile."gdansk.jpg".source = ./gdansk.jpg;

      xdg.configFile."hypr/hyprshade.toml".source = ./hyprshade.toml;
      xdg.configFile."hypr/shaders/blue-light-filter.glsl".source = ./blue-light-filter.glsl;

      wayland.windowManager.hyprland = {
        enable = true;
        extraConfig = builtins.readFile ./hyprland.conf;
        plugins = [ ];
      };
    };

    environment.sessionVariables = {
      ELECTRON_OZONE_PLATFORM_HINT = "auto"; # only works with electron 28+
      NIXOS_OZONE_WL = "1";
    };

  };
}
