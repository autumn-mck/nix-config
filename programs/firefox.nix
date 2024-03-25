{ home-manager, ... }:

{
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
}
