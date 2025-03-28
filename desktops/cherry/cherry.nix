{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = { };

  config = lib.mkIf (config.networking.hostName == "cherry") {
    programs.fw-fanctrl.enable = true;
    programs.fw-fanctrl.config.defaultStrategy = "laziest";

    hardware.graphics.extraPackages = with pkgs; [ rocmPackages.clr.icd ];
  };
}
