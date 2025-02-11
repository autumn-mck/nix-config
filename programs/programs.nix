{
  config,
  lib,
  pkgs,
  home-manager,
  ...
}:

{
  imports = [
    ./hypr/hyprland.nix
    ./mullvad.nix
    ./fish.nix
    ./syncthing/syncthing.nix
    ./javascript.nix
    ./distrobox.nix
    ./pipewire.nix
    ./android.nix
    ./sddm.nix
    ./caddy.nix
    ./forgejo.nix
  ];

  home-manager.users.autumn = {
    imports = [
      ./vscode.nix
      ./firefox.nix
      ./librewolf.nix
      ./thunderbird.nix
      ./hyfetch/hyfetch.nix
      ./kitty.nix
      ./git.nix
      ./swaync/swaync.nix
      ./qtct/qtct.nix
      ./fuzzel.nix
      ./cursor.nix
      ./gtk.nix
      ./waybar/waybar.nix
      ./kde.nix
    ];
  };
}
