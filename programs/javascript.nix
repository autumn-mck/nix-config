{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nodePackages.nodejs
    nodePackages.pnpm
    bun
    yarn
  ];

  programs.npm = {
    enable = true;
    # please stop cluttering up my $HOME
    npmrc = ''
      prefix=/home/autumn/.local/share/npm
      cache=/home/autumn/.cache/npm
      init-module=/home/autumn/.config/npm/config/npm-init.js
    '';
  };
}
