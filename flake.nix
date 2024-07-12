{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = { self, nixpkgs, nixos-hardware, catppuccin, ... }@attrs: {
    nixosConfigurations.cherry = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [
        catppuccin.nixosModules.catppuccin
        ./configuration.nix
        ./hardware/cherry/hardware.nix
      ];
    };

    nixosConfigurations.hawthorn = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [
        catppuccin.nixosModules.catppuccin
        ./configuration.nix
        ./hardware/hawthorn/hardware.nix
      ];
    };

    nixosConfigurations.rowan = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      specialArgs = attrs;
      modules = [
        catppuccin.nixosModules.catppuccin
        ./configuration.nix
        ./hardware/rowan/hardware.nix
      ];
    };
  };
}
