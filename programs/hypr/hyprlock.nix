{ config, pkgs, ... }:

{
  security.pam.services.swaylock = { };
  security.polkit.enable = true;

  environment.systemPackages = with pkgs; [
    hyprlock
  ];

  nixpkgs.overlays = [
    (final: prev: {
      hyprlock = prev.hyprlock.overrideAttrs (old: {
        src = prev.fetchFromGitHub {
          owner = "hyprwm";
          repo = "hyprlock";
          rev = "2ae79757d5e5c48de2f4284992a6bfa265853a2d";
          hash = "sha256-bhep83LkF7tGERJquZ8J54XTFj0GLLXXMJP0EY/5/7o=";
        };
      });
    })
  ];
}
