{ config, pkgs, lib, ... }:

{
  options = {
    fish.enable = lib.mkEnableOption "fish";
  };

  config = lib.mkIf config.fish.enable {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting # Disable greeting
      '';
    };

    environment.systemPackages = with pkgs; [
      grc
      fishPlugins.pure
      fishPlugins.autopair
      fishPlugins.sponge
      fishPlugins.done
      fishPlugins.z
      fishPlugins.grc
      fishPlugins.puffer
    ];
  };
}
