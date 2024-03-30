{ config, home-manager, pkgs, ... }:

{
  imports = [
    ./config/fonts.nix
    ./config/locale.nix
  ];

  options = { };

  config = {
    environment.systemPackages = with pkgs; [
      inkscape

      xdg-utils
      desktop-file-utils # utils for .desktop files

      libreoffice
      hunspell # spell checker
      hunspellDicts.en-gb-ise

      bitwarden-desktop
      vlc
      gimp

      winetricks
      wine-staging # i can't tell what the difference between all the different nix wine packages are, but i tested this one and works for musicbee so good enough

      qbittorrent
      godot_4
      handbrake
      obs-studio
      gimp
      vesktop
      prismlauncher
      dolphin-emu
      #itch
      slipstream
      protonmail-bridge
      cava
      ungoogled-chromium

      gparted
      kdePackages.partitionmanager

      networkmanagerapplet
      brightnessctl

      pavucontrol
      pamixer
      helvum # pipewire graph patchbay thing

      qbittorrent

      jetbrains.rider
      jetbrains.idea-ultimate

      (catppuccin-gtk.override {
        accents = [ "mauve" ];
        size = "compact";
        tweaks = [ "rimless" ];
        variant = "macchiato";
      })
    ];

    programs.steam.enable = true;

    home-manager.users.autumn = {
      kitty.enable = true;

      xdg = {
        enable = true;

        mimeApps = {
          enable = true;
          defaultApplications = {
            # librewolf as browser (pdf files too)
            "x-scheme-handler/http" = "librewolf.desktop";
            "x-scheme-handler/https" = "librewolf.desktop";
            "text/html" = "librewolf.desktop";
            "application/pdf" = "librewolf.desktop";

            # thunderbird as default mail client
            "x-scheme-handler/mailto" = "thunderbird.desktop";

            # gwenview as image viewer
            "image/bmp" = "gwenview.desktop";
            "image/gif" = "gwenview.desktop";
            "image/jpeg" = "gwenview.desktop";
            "image/png" = "gwenview.desktop";
            "image/svg+xml" = "gwenview.desktop";
            "image/tiff" = "gwenview.desktop";

            # gimp as image editor
            "image/x-xcf" = "gimp.desktop";
            "image/x-psd" = "gimp.desktop";

            # VLC as video player
            "video/3gpp" = "vlc.desktop";
            "video/mp4" = "vlc.desktop";
            "video/mpeg" = "vlc.desktop";
            "video/ogg" = "vlc.desktop";
            "video/quicktime" = "vlc.desktop";

            # vscode for text files, csv files, etc
            "text/plain" = "code.desktop";
            "text/csv" = "code.desktop";
          };
        };
      };
    };
  };
}
