{ config, ... }: {
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
      "birch" = { id = "A2ORYU3-3LNBGBU-EZGFMJT-UJQ6WEG-N54TFGO-DY6IOLM-NSUD7NK-XX5ZRAU"; };
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
}
