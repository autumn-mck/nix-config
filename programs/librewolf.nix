{ home-manager, lib, config, ... }:

{
  options = {
    librewolf.enable = lib.mkEnableOption "librewolf";
  };

  config = lib.mkIf config.librewolf.enable {
    programs.librewolf = {
      enable = true;
      settings = {
        "browser.uidensity" = 1;
        "findbar.highlightAll" = true;

        "webgl.disabled" = false;
        "identity.fxaccounts.enabled" = true;
        "privacy.resistFingerprinting" = false;

        "signon.generation.enabled" = false;
        "signon.management.page.breach-alerts.enabled" = false;

        "security.OCSP.require" = false; # breaks with vpn

        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        "privacy.trackingprotection.emailtracking.enabled" = true;
        "privacy.fingerprintingProtection" = true;
        "privacy.donottrackheader.enabled" = true;

        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.tabs.inTitlebar" = 0;
        "media.videocontrols.picture-in-picture.video-toggle.first-seen-secs" = 1;
      };
    };
  };
}
