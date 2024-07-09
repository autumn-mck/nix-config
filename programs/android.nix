{ config, pkgs, lib, ... }:

{
  options = {
    android.enable = lib.mkEnableOption "android";
  };

  config = lib.mkIf config.android.enable {
    programs.adb.enable = true;
    users.users.autumn.extraGroups = [ "adbusers" ];

    environment.shellAliases."adb" = "HOME=\"$XDG_DATA_HOME\"/android ${pkgs.android-tools}/bin/adb";

    environment.systemPackages = with pkgs; [
      android-studio
    ];
  };
}
