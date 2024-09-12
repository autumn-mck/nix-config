{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    catppuccin.url = "github:catppuccin/nix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-hardware, catppuccin, nixos-cosmic, ... }@attrs: {
    nixosConfigurations.cherry = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [
        {
          nix.settings = {
            substituters = [ "https://cosmic.cachix.org/" ];
            trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
          };
        }
        nixos-cosmic.nixosModules.default
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
