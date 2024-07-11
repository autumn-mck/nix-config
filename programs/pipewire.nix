{ config, lib, ... }:

{
  options = {
    pipewire.enable = lib.mkEnableOption "pipewire";
  };

  config = lib.mkIf config.pipewire.enable {
    services.pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
      jack.enable = true;
    };
  };
}
