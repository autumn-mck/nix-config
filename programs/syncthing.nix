{ config, lib, ... }: {
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
        "ash" = { id = "IDPBWDT-5KWVAM7-S4PBX5T-PJN4BYI-SMXS5A7-QFNQRO5-ADRXPSK-AYZOAQT"; };
        "birch" = { id = "A2ORYU3-3LNBGBU-EZGFMJT-UJQ6WEG-N54TFGO-DY6IOLM-NSUD7NK-XX5ZRAU"; };
        "mangrove" = { id = "FPVUK6F-OIHAEEV-L3API4Q-WSLAPXF-H3RH32R-AOD2FTX-QPYEAJH-NDE7XAG"; };
      };

      settings.folders = {
        "qg4t0-4eepi" = {
          label = "AndroidCamera";
          path = "/home/autumn/Pictures/AndroidCamera";
          devices = [ "ash" "birch" "mangrove" ];
        };

        "upigg-w6x5l" = {
          label = "Desktop";
          path = "/home/autumn/Desktop";
          devices = [ "ash" "birch" "mangrove" ];
        };

        "kjmaq-xt5wt" = {
          label = "MusicMain";
          path = "/home/autumn/Music/MusicMain";
          devices = [ "ash" "birch" "mangrove" ];
        };

        "3yaff-abx57" = {
          label = "Documents";
          path = "/home/autumn/Documents/Documents";
          devices = [ "ash" "birch" "mangrove" ];
        };

        "rsjpd-6ubkv" = {
          label = "MusicBackup";
          path = "/home/autumn/Music/MusicBackup";
          devices = [ "birch" ];
        };
      };
    };
  };
}
