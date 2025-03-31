{
  config,
  pkgs,
  lib,
  ...
}:

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
        what = "nvd diff $(ls -d1v /nix/var/nix/profiles/system-*-link|tail -n 2)";
      };
    };

    environment.systemPackages =
      with pkgs.fishPlugins;
      [
        grc
        # fishPlugins.pure
        (pure.overrideAttrs {
          nativeCheckInputs = [ ];
          checkPlugins = [ ];
          checkPhase = "";
        })
        autopair
        sponge
        done
        z
        grc
        puffer
        bang-bang
      ]
      ++ (with pkgs; [
        grc
      ]);
  };
}
