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
      shellAbbrs = {
        update = "sudo nix flake update /home/autumn/Desktop/Projects/nix-config/ && rm ~/.gtkrc-2.0 && sudo nixos-rebuild switch --flake '/home/autumn/Desktop/Projects/nix-config/#'";
      };
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
