{ config, lib, pkgs, home-manager, ... }:

{
  imports =
    [
      ./hardware/cherry/hardware.nix
      home-manager.nixosModules.default
      ./programs/hypr/hyprland.nix
      ./programs/mullvad.nix
      ./programs/fish.nix
      ./programs/syncthing.nix
      ./programs/javascript.nix
      ./programs/distrobox.nix
      ./programs/pipewire.nix
      ./declutterHome.nix
      ./bluetooth.nix
      ./desktops/desktop.nix
      ./desktops/cherry/cherry.nix
    ];

  fish.enable = true;
  distrobox.enable = true;

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.systemd-boot.configurationLimit = 20;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "cherry";

  networking.networkmanager.enable = true;

  users.users.autumn = {
    isNormalUser = true;
    description = "autumn";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    use-xdg-base-directories = true;
  };

  # Packages
  environment.systemPackages = with pkgs; [
    git
    unzip
    p7zip
    unrar
    curl
    wget

    imagemagick

    bottom
    tealdeer
    bat
    shellcheck
    tree

    cargo
    rustc

    dotnet-sdk_8
    dotnet-runtime_8
    dotnet-aspnetcore_8

    whois
    xdg-ninja
    geekbench

    nixpkgs-fmt

    jetbrains.rider
    jetbrains.idea-ultimate

    podman-compose

    (catppuccin-gtk.override {
      accents = [ "mauve" ];
      size = "compact";
      tweaks = [ "rimless" ];
      variant = "macchiato";
    })
  ];

  # Services
  # services.openssh.enable = true;

  home-manager.useGlobalPkgs = true;
  home-manager.users.autumn = {
    home.stateVersion = "23.11";

    imports = [
      ./programs/vscode.nix
      ./programs/firefox.nix
      ./programs/librewolf.nix
      ./programs/thunderbird.nix
      ./programs/hyfetch/hyfetch.nix
      ./programs/kitty.nix
      ./programs/git.nix
      ./programs/swaync/swaync.nix
      ./programs/qtct/qtct.nix
      ./programs/fuzzel.nix
      ./programs/cursor.nix
      ./programs/gtk.nix
    ];

    kitty.enable = true;
    cursor.enable = true;
    firefox.enable = true;
    fuzzel.enable = true;

    xdg.configFile."hypr/hyprland.conf".source = ./programs/hypr/hyprland.conf;
    xdg.configFile."hypr/scripts/screenshot.sh".source = ./programs/hypr/screenshot.sh;

    home.packages = [
    ];
  };

  environment.sessionVariables = {
    DOTNET_CLI_TELEMETRY_OPTOUT = "1";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
