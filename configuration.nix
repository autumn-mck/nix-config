{ config, lib, pkgs, home-manager, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      home-manager.nixosModules.default
    ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 20;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

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

    kitty
    neofetch
    hyfetch
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

    nodePackages.nodejs
    bun
    nodePackages.pnpm
    yarn

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
    protonmail-bridge
    cava
    xdg-ninja
    ungoogled-chromium
    geekbench

    grc
    fishPlugins.pure
    fishPlugins.autopair
    fishPlugins.sponge
    fishPlugins.done
    fishPlugins.z
    fishPlugins.grc
    fishPlugins.puffer

    pcmanfm

    waybar
    gparted
    kdePackages.partitionmanager
    hyprshade
    networkmanagerapplet
    helvum
    pavucontrol
    pamixer
    brightnessctl

    flameshot
    grim
    slurp
    swappy
    wl-clipboard

    libnotify
    swaynotificationcenter

    swaylock-effects
    hyprlock

    bemoji
    fuzzel
    cliphist
    wl-clip-persist

    swww
    waypaper

    lxqt.lxqt-policykit

    libsForQt5.dolphin # kde6 version seems to run through xwayland for some reason, kde5 version is fine for now
    libsForQt5.ark

    qt5ct
    qt6ct
    catppuccin-qt5ct
    lightly-boehs

    libsForQt5.gwenview

    qbittorrent

    nixpkgs-fmt

    (catppuccin-gtk.override {
      accents = [ "mauve" ];
      size = "compact";
      tweaks = [ "rimless" ];
      variant = "macchiato";
    })
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

  programs.hyprland.enable = true;
  # TODO set up hyprshade

  programs.steam.enable = true;

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
  };

  programs.npm = {
    enable = true;
    # please stop cluttering up my $HOME
    npmrc = ''
      prefix=/home/autumn/.local/share/npm
      cache=/home/autumn/.cache/npm
      init-module=/home/autumn/.config/npm/config/npm-init.js
    '';
  };

  # Services
  services.fwupd.enable = true;
  # we need fwupd 1.9.7 to downgrade the fingerprint sensor firmware
  # (from https://github.com/NixOS/nixos-hardware/tree/master/framework/13-inch/7040-amd#getting-the-fingerprint-sensor-to-work)
  services.fwupd.package = (import
    (builtins.fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/bb2009ca185d97813e75736c2b8d1d8bb81bde05.tar.gz";
      sha256 = "sha256:003qcrsq5g5lggfrpq31gcvj82lb065xvr7bpfa8ddsw8x4dnysk";
    })
    {
      inherit (pkgs) system;
    }).fwupd;

  services.resolved.enable = true;
  services.mullvad-vpn.enable = true;
  services.mullvad-vpn.package = pkgs.mullvad-vpn;

  security.pam.services.swaylock = { };
  security.polkit.enable = true;

  services.blueman.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    jack.enable = true;
  };

  services.syncthing = {
    enable = true;
    user = "autumn";
    dataDir = "/home/autumn";
    configDir = "/home/autumn/.config/syncthing";
    overrideDevices = true;
    overrideFolders = true;
    openDefaultPorts = true;

    settings.devices = {
      "hazel" = { id = "KKYBFUF-45PZX63-5INJFI2-YAWLHGI-D63E3SN-5REEN4C-5UZF2BL-WF5UWAC"; };
      "birch" = { id = "45HXHZR-C3HOKZA-7IDK7J3-DQCFRHF-QUUTSMU-RNNZ65R-2VRRIS7-BLEFNAH"; };
      "mangrove" = { id = "FPVUK6F-OIHAEEV-L3API4Q-WSLAPXF-H3RH32R-AOD2FTX-QPYEAJH-NDE7XAG"; };
    };

    settings.folders = {
      "qg4t0-4eepi" = {
        label = "AndroidCamera";
        path = "/home/autumn/Pictures/AndroidCamera";
        devices = [ "hazel" "birch" "mangrove" ];
      };

      "upigg-w6x5l" = {
        label = "Desktop";
        path = "/home/autumn/Desktop";
        devices = [ "hazel" "birch" "mangrove" ];
      };

      "kjmaq-xt5wt" = {
        label = "MusicMain";
        path = "/home/autumn/Music/MusicMain";
        devices = [ "hazel" "birch" "mangrove" ];
      };

      "3yaff-abx57" = {
        label = "Documents";
        path = "/home/autumn/Documents/Documents";
        devices = [ "birch" "mangrove" ];
      };

      "rsjpd-6ubkv" = {
        label = "MusicBackup";
        path = "/home/autumn/Music/MusicBackup";
        devices = [ "birch" ];
      };
    };
  };

  # services.openssh.enable = true;

  home-manager.useGlobalPkgs = true;
  home-manager.users.autumn = {
    home.stateVersion = "23.11";

    imports = [
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



    programs.git = {
      enable = true;
      userEmail = "autumn@mck.is";
      userName = "Autumn McKee";
      extraConfig = {
        init.defaultBranch = "main";
      };
    };

    programs.hyfetch = {
      enable = true;
      settings = {
        preset = "transgender";
        mode = "rgb";
        light_dark = "dark";
        lightness = 0.65;
        color_align = {
          mode = "horizontal";
        };
        backend = "neofetch";
      };
    };

    programs.librewolf = {
      enable = true;
      settings = {
        "browser.uidensity" = 1;
        "findbar.highlightAll" = true;

        "webgl.disabled" = false;
        "identity.fxaccounts.enabled" = true;
        "privacy.resistFingerprinting" = false;

        "browser.toolbars.bookmarks.visibility" = "never";
        "media.videocontrols.picture-in-picture.video-toggle.first-seen-secs" = 1;
      };
    };

    programs.firefox = {
      enable = true;
      profiles.autumn = {
        settings = {
          "browser.uidensity" = 1;
          "findbar.highlightAll" = true;

          "app.normandy.first_run" = false;
          "trailhead.firstrun.didSeeAboutWelcome" = true;
          "app.shield.optoutstudies.enabled" = false;
          "browser.aboutConfig.showWarning" = false;
          "browser.discovery.enabled" = false;
          "toolkit.telemetry.reportingpolicy.firstRun" = false;
          "trailhead.firstrun.branches" = "nofirstrun-empty";
          "browser.aboutwelcome.enabled" = false;

          "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
          "browser.newtabpage.activity-stream.feeds.topsites" = false;
          "browser.newtabpage.activity-stream.showSponsored" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;

          "browser.safebrowsing.downloads.enabled" = false;
          "browser.safebrowsing.downloads.remote.block_potentially_unwanted" = false;
          "browser.safebrowsing.downloads.remote.block_uncommon" = false;
          "browser.safebrowsing.malware.enabled" = false;
          "browser.safebrowsing.phishing.enabled" = false;

          "privacy.donottrackheader.enabled" = true;
          "privacy.globalprivacycontrol.enabled" = true;
          "privacy.trackingprotection.enabled" = true;
          "privacy.fingerprintingProtection" = true;
          "privacy.trackingprotection.socialtracking.enabled" = true;
          "privacy.annotate_channels.strict_list.enabled" = true;

          "browser.toolbars.bookmarks.visibility" = "never";
          "media.videocontrols.picture-in-picture.video-toggle.first-seen-secs" = 1;
        };
      };
    };

    programs.thunderbird = {
      enable = true;
      profiles.autumn = {
        isDefault = true;
        settings = {
          "findbar.highlightAll" = true;
          "privacy.donottrackheader.enabled" = true;
          "app.donation.eoy.version.viewed" = 10;
        };
      };
    };


    programs.vscode = {
      enable = true;
      # sandboxes vscode, which allows extensions to work without additional configuration,
      # but as a result prevents elevated permissions from being used in the terminal (e.g. sudo)
      # (might look at this again later, but commented out is fine for now)
      #package = pkgs.vscode.fhs;
      extensions = with pkgs.vscode-extensions; [
        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons

        mhutchie.git-graph

        esbenp.prettier-vscode

        github.copilot

        coolbear.systemd-unit-file
        jnoortheen.nix-ide
        unifiedjs.vscode-mdx
        astro-build.astro-vscode
      ];
      userSettings = {
        "workbench.colorTheme" = "Catppuccin Macchiato";
        "workbench.iconTheme" = "catppuccin-macchiato";

        "editor.tabSize" = 2;
        "editor.insertSpaces" = false;
        "editor.inlineSuggest.enabled" = true;
        "editor.renderWhitespace" = "trailing";
        "editor.formatOnSave" = true;

        "terminal.external.linuxExec" = "kitty";
        "terminal.integrated.defaultProfile.linux" = "fish";
        "window.menuBarVisibility" = "toggle";

        "editor.defaultFormatter" = "esbenp.prettier-vscode";
        "prettier.printWidth" = 100;
        "prettier.bracketSameLine" = true;
        "prettier.useTabs" = true;

        "git.autofetch" = true;
        "git.enableSmartCommit" = true;
        "git.confirmSync" = false;

        "explorer.confirmSync" = false;

        "[nix]" = {
          "editor.defaultFormatter" = "jnoortheen.nix-ide";
        };

        "[astro]" = {
          "editor.defaultFormatter" = "astro-build.astro-vscode";
        };
      };
    };
  };

  fonts.packages = with pkgs; [
    twitter-color-emoji
    (nerdfonts.override { fonts = [ "IBMPlexMono" ]; })
  ];

  environment.sessionVariables = rec {
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_STATE_HOME = "$HOME/.local/state";
    XDG_CACHE_HOME = "$HOME/.cache";

    XDG_BIN_HOME = "$HOME/.local/bin";
    PATH = [
      "${XDG_BIN_HOME}"
    ];

    HISTFILE = "${XDG_STATE_HOME}/bash/history";
    LESSHISTFILE = "${XDG_CACHE_HOME}/less/history";
    PASSWORD_STORE_DIR = "${XDG_DATA_HOME}/pass";
    WINEPREFIX = "${XDG_DATA_HOME}/wine";
    CUDA_CACHE_PATH = "${XDG_CACHE_HOME}/nv";

    GOPATH = "${XDG_DATA_HOME}/go";
    CARGO_HOME = "${XDG_DATA_HOME}/cargo";
    RUSTUP_HOME = "${XDG_DATA_HOME}/rustup";
    DOCKER_CONFIG = "${XDG_CONFIG_HOME}/docker";
    DOTNET_CLI_HOME = "${XDG_DATA_HOME}/dotnet";
    ELECTRUMDIR = "${XDG_DATA_HOME}/electrum";
    NODE_REPL_HISTORY = "${XDG_DATA_HOME}/node_repl_history";
    NUGET_PACKAGES = "${XDG_CACHE_HOME}/NuGetPackages";
    ANDROID_USER_HOME = "${XDG_DATA_HOME}/android";
    ANDROID_HOME = "${XDG_DATA_HOME}/android/sdk";
    GRADLE_USER_HOME = "${XDG_DATA_HOME}/gradle";

    DOTNET_CLI_TELEMETRY_OPTOUT = "1";

    ELECTRON_OZONE_PLATFORM_HINT = "auto";
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
