{ config, lib, pkgs, home-manager, ... }:

{
  imports =
    [
      ./hardware/cherry/hardware.nix
      home-manager.nixosModules.default
      ./declutterHome.nix
      ./bluetooth.nix
      ./desktops/desktop.nix
      ./desktops/cherry/cherry.nix
      ./programs/programs.nix
    ];

  fish.enable = true;
  distrobox.enable = true;
  js.enable = true;

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.systemd-boot.configurationLimit = 20;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  console.catppuccin.enable = true;
  console.catppuccin.flavor = "macchiato";

  networking.hostName = "cherry";

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

  programs.command-not-found.enable = false; # broken when using only flakes

  # Packages
  environment.systemPackages = with pkgs; [
    # pretty important
    git
    unzip
    p7zip
    unrar
    curl
    wget

    imagemagick

    # system monitoring
    bottom
    btop

    # useful utils
    shellcheck
    whois

    tealdeer
    bat

    # rust
    cargo
    rustc

    # dotnet stuff
    dotnet-sdk_8
    dotnet-runtime_8
    dotnet-aspnetcore_8

    # benchmarking
    geekbench

    # unimportant utils
    xdg-ninja
    nixpkgs-fmt

    podman-compose

    material-icons
  ];

  environment.sessionVariables = {
    DOTNET_CLI_TELEMETRY_OPTOUT = "1";
  };

  home-manager.useGlobalPkgs = true;
  home-manager.users.autumn = {
    home.stateVersion = "23.11";
    git.enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
