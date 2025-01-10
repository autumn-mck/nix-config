{ config, lib, ... }:

{
  options = { };

  config = lib.mkIf (config.networking.hostName == "cherry") {
    programs.fw-fanctrl.enable = true;
    programs.fw-fanctrl.config.defaultStrategy = "laziest";
  };
}

