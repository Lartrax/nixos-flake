{
  description = "My NixOS setup flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { self, nixpkgs, chaotic, home-manager, hyprland }@inputs:
    let system = "x86_64-linux";

    in {

      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs system; };

          modules = [
            ./hosts/desktop/configuration.nix
            ./modules/defaults.nix
            ./modules/fonts/monaspace.nix
            ./modules/audio.nix
            ./modules/nvidia.nix
            chaotic.nixosModules.default
            ./modules/kernels/cachyos-lto.nix
          ];
        };
        laptop = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs system; };

          modules = [
            ./hosts/laptop/configuration.nix
            ./modules/defaults.nix
            ./modules/fonts/monaspace.nix
            ./modules/audio.nix
            ./modules/kernels/linux-latest.nix
          ];
        };
      };

    };
}
