{ config, lib, pkgs, home-manager, ... }:

{
  imports =
    [
      ./hardware/cherry/hardware.nix
      home-manager.nixosModules.default
      ./programs/hypr/hyprland.nix
      ./programs/mullvad.nix
      ./programs/fish.nix
      ./programs/syncthing.nix
      ./programs/javascript.nix
      ./programs/distrobox.nix
      ./declutterHome.nix
      ./bluetooth.nix
    ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.systemd-boot.configurationLimit = 20;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "cherry";

  networking.networkmanager.enable = true;

  # Europe/Belfast is just a link to Europe/London for now, but still nice to have
  time.timeZone = "Europe/Belfast";

  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };

  console.keyMap = "uk";

  users.users.autumn = {
    isNormalUser = true;
    description = "autumn";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    use-xdg-base-directories = true;
  };

  # Packages
  environment.systemPackages = with pkgs; [
    git
    unzip
    p7zip
    unrar
    wget

    imagemagick
    inkscape

    xdg-utils
    desktop-file-utils

    neofetch
    bottom
    tealdeer
    bat
    shellcheck
    tree

    cargo
    rustc

    dotnet-sdk_8
    dotnet-runtime_8
    dotnet-aspnetcore_8

    libreoffice
    hunspell
    hunspellDicts.en-gb-ise

    bitwarden-desktop
    vlc
    gimp

    winetricks
    wine-staging
    qbittorrent
    whois
    godot_4
    handbrake
    obs-studio
    gimp
    vesktop
    prismlauncher
    dolphin-emu
    #itch
    protonmail-bridge
    cava
    xdg-ninja
    ungoogled-chromium
    geekbench

    pcmanfm

    gparted
    kdePackages.partitionmanager
    networkmanagerapplet
    helvum
    pavucontrol
    pamixer
    brightnessctl

    qbittorrent

    nixpkgs-fmt

    jetbrains.rider
    jetbrains.idea-ultimate

    podman-compose

    (catppuccin-gtk.override {
      accents = [ "mauve" ];
      size = "compact";
      tweaks = [ "rimless" ];
      variant = "macchiato";
    })
  ];

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  programs.steam.enable = true;

  # Services
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    jack.enable = true;
  };

  # services.openssh.enable = true;

  home-manager.useGlobalPkgs = true;
  home-manager.users.autumn = {
    home.stateVersion = "23.11";

    imports = [
      ./programs/vscode.nix
      ./programs/firefox.nix
      ./programs/librewolf.nix
      ./programs/thunderbird.nix
      ./programs/hyfetch.nix
      ./programs/kitty.nix
      ./programs/git.nix
    ];

    home.packages = [
    ];

    home.pointerCursor = {
      package = pkgs.catppuccin-cursors.macchiatoMauve;
      name = "Catppuccin-Macchiato-Mauve-Cursors";
      gtk.enable = true;
      size = 48;
    };

    gtk.cursorTheme = {
      name = "Catppuccin-Macchiato-Mauve-Cursors";
      size = 48;
    };

    gtk = {
      enable = true;
      theme = {
        name = "Catppuccin-Macchiato-Compact-Mauve-Dark";
        package = pkgs.catppuccin-gtk.override {
          accents = [ "mauve" ];
          size = "compact";
          tweaks = [ "rimless" ];
          variant = "macchiato";
        };
      };
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.catppuccin-papirus-folders.override {
          accent = "mauve";
          flavor = "macchiato";
        };
      };
    };

    qt.enable = true;
    qt.platformTheme = "qtct";

    xdg = {
      enable = true;

      configFile = {
        "gtk-4.0/assets".source = "${config.home-manager.users.autumn.gtk.theme.package}/share/themes/${config.home-manager.users.autumn.gtk.theme.name}/gtk-4.0/assets";
        "gtk-4.0/gtk.css".source = "${config.home-manager.users.autumn.gtk.theme.package}/share/themes/${config.home-manager.users.autumn.gtk.theme.name}/gtk-4.0/gtk.css";
        "gtk-4.0/gtk-dark.css".source = "${config.home-manager.users.autumn.gtk.theme.package}/share/themes/${config.home-manager.users.autumn.gtk.theme.name}/gtk-4.0/gtk-dark.css";
      };

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

  fonts.packages = with pkgs; [
    twitter-color-emoji
    (nerdfonts.override { fonts = [ "IBMPlexMono" ]; })
  ];

  environment.sessionVariables = {
    DOTNET_CLI_TELEMETRY_OPTOUT = "1";

    ELECTRON_OZONE_PLATFORM_HINT = "auto"; # only works with electron 28+
    NIXOS_OZONE_WL = "1";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
