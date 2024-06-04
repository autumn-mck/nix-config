{ config, lib, ... }:

{
  options = {
    locale = lib.mkOption {
      type = lib.types.str;
      default = "en_GB.UTF-8";
      description = "The system locale.";
    };

    timeZone = lib.mkOption {
      type = lib.types.str;
      default = "Europe/Belfast";
      description = "The system time zone.";
    };
  };

  config = {
    time.timeZone = "Europe/Berlin";

    i18n.defaultLocale = config.locale;
    i18n.extraLocaleSettings = {
      LC_ADDRESS = config.locale;
      LC_IDENTIFICATION = config.locale;
      LC_MEASUREMENT = config.locale;
      LC_MONETARY = config.locale;
      LC_NAME = config.locale;
      LC_NUMERIC = config.locale;
      LC_PAPER = config.locale;
      LC_TELEPHONE = config.locale;
      LC_TIME = config.locale;
    };
  };
}
