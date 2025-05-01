{
  config,
  home-manager,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./config/fonts.nix
    ./config/locale.nix
    ./bluetooth.nix
    ./cherry/cherry.nix
  ];

  options = {
    isDesktop = lib.mkEnableOption "isDesktop";
  };

  config = lib.mkIf (config.isDesktop) {
    networking.networkmanager.enable = true;
    users.users.autumn.extraGroups = [
      "networkmanager"
      "libvirtd"
      "dialout"
      "vboxusers"
      "wireshark"
    ];

    boot.kernelModules = [ "i2c-dev" ];
    boot.supportedFilesystems = [ "ntfs" ];
    hardware.i2c.enable = true;

    environment.systemPackages = with pkgs; [
      # image stuff
      inkscape
      gimp3

      # office
      libreoffice
      hunspell # spell checker
      hunspellDicts.en-gb-ise
      kdePackages.okular # pdf/epub/djvu viewer

      # wine
      winetricks
      wine-staging # idk what the difference between all the different wine packages are, but this one works for musicbee so good enough

      # video
      handbrake
      obs-studio
      vlc

      # gaming
      # steam is enabled below
      prismlauncher
      dolphin-emu
      itch
      slipstream # FTL mod manager, run from command line

      # communication
      # thunderbird is managed by home-manager
      vesktop
      protonmail-bridge
      teams-for-linux
      whatsapp-for-linux
      cinny-desktop
      signal-desktop

      # browsers
      ungoogled-chromium
      # librewolf and firefox are both managed by home-manager

      # utils
      gparted
      kdePackages.partitionmanager
      bitwarden-desktop
      amdgpu_top
      usbutils
      kdiskmark

      # command line utils
      xdg-utils
      desktop-file-utils # utils for .desktop files
      brightnessctl
      ddcutil

      # audio
      pavucontrol
      pamixer
      helvum # pipewire graph patchbay thing
      cava
      youtube-music

      # editors
      # vscode managed by home manager
      jetbrains.rider
      jetbrains.idea-ultimate
      godot_4
      obsidian
      arduino-ide
      kdePackages.kdenlive # (stretching a bit)
      kdePackages.kate

      # other dev stuff
      jdk
      python3
      tio
      gnome-boxes

      # network stuff
      qbittorrent
      networkmanagerapplet
      wireshark

      # misc
      material-icons
      kdePackages.breeze
      pandoc
      texlive.combined.scheme-small

      waybar

      ghidra
      okteta
      gobuster
      stegseek
      netcat-gnu
      nmap

      ollama

      (catppuccin-kde.override {
        flavour = [ "macchiato" ];
        accents = [ "mauve" ];
      })
    ];

    environment.etc."/xdg/menus/applications.menu".text =
      builtins.readFile "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";

    nixpkgs.overlays = [
      (final: prev: {
        waybar = prev.waybar.overrideAttrs (old: {
          src = prev.fetchFromGitHub {
            owner = "matt-fff";
            repo = "Waybar";
            rev = "f7b4451564dd860bfacfc293d0bbd414e6bb4e54";
            hash = "sha256-dG7K1r+dOI2Mu09uyJJc1GWoZZke1CD160qIbVzch5Q=";
          };
        });
      })
    ];

    bluetooth.enable = true;

    services.flatpak.enable = true;
    systemd.services.flatpak-repo = {
      wantedBy = [ "multi-user.target" ];
      path = [ pkgs.flatpak ];
      script = ''
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
      '';
    };

    virtualisation.libvirtd.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;

    programs.steam.enable = true;
    programs.wireshark.enable = true;

    services.cpupower-gui.enable = true;

    android.enable = true;
    pipewire.enable = true;
    sddm.enable = true;
    plymouth.enable = true;

    services.xserver.enable = true;
    services.desktopManager.plasma6.enable = true;

    services.desktopManager.cosmic.enable = true;
    syncthing.enable = true;
    hyprland.enable = true;
    mullvad.enable = true;
    virtualbox.enable = true;

    services.printing.enable = false;
    services.gnome.gnome-keyring.enable = true;

    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    home-manager.users.autumn = {
      kitty.enable = true;
      cursor.enable = true;
      firefox.enable = true;
      fuzzel.enable = true;
      waybar.enable = true;
      swaync.enable = true;
      qtct.enable = true;
      thunderbird.enable = true;
      vscode.enable = true;
      librewolf.enable = true;
      gtkTheming.enable = true;
      kde.enable = true;

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
            "video/x-matroska" = "vlc.desktop";
            "video/ogg" = "vlc.desktop";
            "video/quicktime" = "vlc.desktop";

            # vscode for text files, csv files, etc
            "text/plain" = "code.desktop";
            "text/csv" = "code.desktop";
            "application/json" = "code.desktop";
            "application/xml" = "code.desktop";
            "application/x-yaml" = "code.desktop";
            "text/x-cmake" = "code.desktop";
            "text/markdown" = "code.desktop";
          };
        };
      };
    };
  };
}
