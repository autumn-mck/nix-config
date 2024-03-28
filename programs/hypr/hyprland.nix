{ config, lib, pkgs, ... }:

# stuff for hyprland

{
  imports = [
    ./hyprlock.nix
  ];

  programs.hyprland.enable = true;
  # TODO set up hyprshade

  # packages for WM stuff
  environment.systemPackages = with pkgs; [
    hyprshade

    waybar
    flameshot
    grim
    slurp
    swappy
    wl-clipboard

    bemoji
    cliphist
    wl-clip-persist

    swww
    waypaper

    lxqt.lxqt-policykit

    libsForQt5.dolphin # kde6 version seems to run through xwayland for some reason, kde5 version is fine for now
    libsForQt5.ark

    lightly-boehs

    libsForQt5.gwenview
  ];

  nixpkgs.overlays = [
    (final: prev: {
      flameshot = prev.flameshot.overrideAttrs (old: {
        src = prev.fetchFromGitHub {
          owner = "flameshot-org";
          repo = "flameshot";
          rev = "3d21e4967b68e9ce80fb2238857aa1bf12c7b905";
          hash = "sha256-OLRtF/yjHDN+sIbgilBZ6sBZ3FO6K533kFC1L2peugc=";
        };
        NIX_CFLAGS_COMPILE = "-DUSE_WAYLAND_GRIM=1";
      });
    })
  ];
}
