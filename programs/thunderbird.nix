{ home-manager, lib, config, ... }:

{
  options = {
    thunderbird.enable = lib.mkEnableOption "thunderbird";
  };

  config = lib.mkIf (config.thunderbird.enable) {
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
  };
}
