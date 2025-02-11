{
  config,
  lib,
  home-manager,
  ...
}:
let
  folders = config.services.syncthing.settings.folders;
in
{
  options = {
    syncthing.enable = lib.mkEnableOption "syncthing";
  };

  config = lib.mkIf (config.syncthing.enable) {
    services.syncthing = {
      enable = true;
      user = "autumn";
      dataDir = "/home/autumn";
      configDir = "/home/autumn/.config/syncthing";
      overrideDevices = true;
      overrideFolders = true;
      openDefaultPorts = true;

      settings.devices = {
        "ash" = {
          id = "IDPBWDT-5KWVAM7-S4PBX5T-PJN4BYI-SMXS5A7-QFNQRO5-ADRXPSK-AYZOAQT";
        };
        "birch" = {
          id = "A2ORYU3-3LNBGBU-EZGFMJT-UJQ6WEG-N54TFGO-DY6IOLM-NSUD7NK-XX5ZRAU";
        };
        "mangrove" = {
          id = "NPWFF4B-PKT5GD3-QDDNC2K-GUGJMPQ-5XOJU3M-JYO5RRG-76D4VEB-O6T24AW";
        };
      };

      settings.folders = {
        "qg4t0-4eepi" = {
          label = "AndroidCamera";
          path = "/home/autumn/Pictures/AndroidCamera";
          devices = [
            "ash"
            "birch"
            "mangrove"
          ];
        };

        "upigg-w6x5l" = {
          label = "Desktop";
          path = "/home/autumn/Desktop";
          devices = [
            "ash"
            "birch"
          ];
        };

        "kjmaq-xt5wt" = {
          label = "MusicMain";
          path = "/home/autumn/Music/MusicMain";
          devices = [
            "ash"
            "birch"
            "mangrove"
          ];
        };

        "3yaff-abx57" = {
          label = "Documents";
          path = "/home/autumn/Documents/Documents";
          devices = [
            "ash"
            "birch"
          ];
        };

        "rsjpd-6ubkv" = {
          label = "MusicBackup";
          path = "/home/autumn/Music/MusicBackup";
          devices = [ "birch" ];
        };
      };
    };

    home-manager.users.autumn = {
      home.file."${folders."upigg-w6x5l".path}/.stignore".source = ./stignore;
    };
  };
}
