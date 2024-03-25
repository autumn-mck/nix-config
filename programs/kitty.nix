{ home-manager, ... }:

{
  programs.kitty = {
    enable = true;
    theme = "Catppuccin-Macchiato";
    environment = {
      "SHELL" = "fish";
    };

    settings = {
      background_opacity = "0.8";
      shell = "fish";
    };
  };
}
