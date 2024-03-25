{ home-manager, ... }:

{
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
}
