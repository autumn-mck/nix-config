{
  config,
  pkgs,
  lib,
  ...
}:

{
  options = {
    plymouth.enable = lib.mkEnableOption "plymouth";
  };

  config = lib.mkIf config.plymouth.enable {
    boot = {
      loader.timeout = 0;

      plymouth = {
        enable = true;
        theme = "colorful";
        themePackages = with pkgs; [
          (adi1090x-plymouth-themes.override {
            selected_themes = [
              "colorful"
              "pixels"
            ];
          })
        ];
      };

      consoleLogLevel = 3;
      initrd.verbose = false;
      kernelParams = [
        "quiet"
        "splash"
        "boot.shell_on_fail"
        "udev.log_priority=3"
        "rd.systemd.show_status=auto"
      ];
    };

  };
}
