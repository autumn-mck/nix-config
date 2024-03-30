{ config, lib, ... }:

{
  options = {
    pipewire.enable = lib.mkEnableOption "pipewire";
  };

  config = {
    services.pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
      jack.enable = true;
    };
  };
}
