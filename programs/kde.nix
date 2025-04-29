{
  home-manager,
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    kde.enable = lib.mkEnableOption "kde";
  };

  config = lib.mkIf (config.kde.enable) {
    programs.plasma = {
      enable = true;

      workspace = {
        cursor = {
          theme = "catppuccin-macchiato-mauve-cursors";
          size = 32;
        };
        colorScheme = "Catppuccin-Macchiato-Mauve";
        splashScreen.theme = "Catppuccin-Macchiato-Mauve";
        wallpaper = ../imgs/gdansk.jpg;
      };

      desktop = {
        mouseActions.verticalScroll = "switchVirtualDesktop";
      };

      input = {
        keyboard = {
          layouts = [ { layout = "gb"; } ];
        };

        touchpads = [
          {
            name = "PIXA3854:00 093A:0274 Touchpad";
            vendorId = "093A";
            productId = "0274";
            enable = true;
            disableWhileTyping = true;
            naturalScroll = true;
            tapToClick = true;
          }
        ];
      };

      kwin = {
        effects = {
          blur.enable = true;
          cube.enable = true;
          desktopSwitching.animation = "slide";
        };

        nightLight = {
          enable = true;
          mode = "location";
          location = {
            latitude = "54.6";
            longitude = "-6.4";
          };

          temperature = {
            day = 6500;
            night = 4200;
          };
        };

        scripts = {
          polonium = {
            enable = true;
            settings = {
              borderVisibility = "noBorderTiled";
              filter.processes = [
                "krunner"
                "polkit"
                "plasmashell"
                "org.kde.kdialog"
                "org.kde.spectacle"
                "bitwarden"
                "musicbee.exe"
                "systemsettings"
              ];
            };
          };
        };

        titlebarButtons.right = [
          "minimize"
          "maximize"
          "close"
        ];
        virtualDesktops.number = 8;
        virtualDesktops.rows = 2;
      };

      panels = [
        {
          height = 24;
          floating = false;
          hiding = "normalpanel";
          location = "top";
          screen = "all";
          widgets = [
            {
              name = "org.kde.plasma.kickoff";
              config = {
                General = {
                  icon = "nix-snowflake-white"; # kde-symbolic
                  primaryActions = "3";
                  showActionButtonCaptions = "false";
                  systemFavorites = "lock-screen\\\\,logout\\\\,save-session\\\\,switch-user\\\\,suspend\\\\,hibernate\\\\,reboot\\\\,shutdown";
                };
              };
            }

            {
              name = "org.kde.plasma.pager";
              config.General.wrapPage = true;
            }

            {
              iconTasks = {
                launchers = [
                  "applications:org.kde.dolphin.desktop"
                  "preferred://browser"
                  "applications:kitty.desktop"
                  "applications:MusicBee.desktop"
                  "applications:code.desktop"
                ];
              };
            }

            "org.kde.plasma.panelspacer"

            {
              applicationTitleBar = {
                layout.elements = [
                  "windowTitle"
                ];

                windowTitle = {
                  maximumWidth = 400;
                  font = {
                    bold = false;
                    fit = "fit";
                    size = 11;
                  };
                  undefinedWindowTitle = ":3";
                };

              };
            }

            "org.kde.plasma.panelspacer"

            "org.kde.plasma.colorpicker"

            {
              name = "org.kde.plasma.systemmonitor.cpucore";
              config = {
                Appearance = {
                  chartFace = "org.kde.ksysguard.barchart";
                  title = "Individual Core Usage";
                  updateRateLimit = "500";
                };
              };
            }

            {
              systemTray.items = {
                # We explicitly show bluetooth and battery
                shown = [
                  "org.kde.plasma.battery"
                  "org.kde.plasma.bluetooth"
                ];
                # And explicitly hide networkmanagement and volume
                hidden = [
                ];
              };
            }

            {
              digitalClock = {
                calendar.firstDayOfWeek = "monday";
                time.format = "24h";
                date.enable = false;
              };
            }

            {
              applicationTitleBar = {
                layout.elements = [
                  "windowMaximizeButton"
                  "windowCloseButton"
                ];
                windowControlButtons.iconSource = "breeze";
              };
            }
          ];
        }
      ];

      fonts = {
        general = {
          family = "IBM Plex Sans";
          pointSize = 10;
        };

        fixedWidth = {
          family = "Mononoki Nerd Font";
          pointSize = 10;
        };

        menu = {
          family = "IBM Plex Sans";
          pointSize = 10;
        };

        small = {
          family = "IBM Plex Sans";
          pointSize = 8;
        };

        toolbar = {
          family = "IBM Plex Sans";
          pointSize = 10;
        };

        windowTitle = {
          family = "IBM Plex Sans";
          pointSize = 10;
        };
      };

      configFile.kwinrc = {
        Windows = {
          DelayFocusInterval = "0";
          FocusPolicy = "FocusFollowsMouse";
          NextFocusPrefersMouse = "true";
          RollOverDesktops = "true";
        };
      };
    };
  };
}
