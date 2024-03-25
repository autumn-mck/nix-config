{ home-manager, ... }:

{
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
}
