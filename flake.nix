{
  description = "My NixOS setup flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
  };

  outputs = { self, nixpkgs, nixos-wsl, nix-cachyos-kernel, home-manager
    , nix-minecraft, hyprland }@inputs:
    let system = "x86_64-linux";

    in {

      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs system; };

          modules = [
            ./hosts/desktop/configuration.nix
            ./modules/defaults.nix
            ./modules/bootloader.nix
            ./modules/fonts/monaspace.nix
            ./modules/audio.nix
            ./modules/nvidia.nix
            ({ pkgs, ... }: {
              nixpkgs.overlays = [ nix-cachyos-kernel.overlays.pinned ];
            })
            ./modules/kernels/cachyos-lto.nix
            ./modules/automount.nix
            ./modules/fish.nix
            ./modules/network.nix
            ./modules/ssh.nix
            ./modules/minecraft.nix
          ];
        };
        laptop = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs system; };

          modules = [
            ./hosts/laptop/configuration.nix
            ./modules/defaults.nix
            ./modules/bootloader.nix
            ./modules/fonts/monaspace.nix
            ./modules/audio.nix
            ./modules/graphics.nix
            ./modules/kernels/linux-latest.nix
            ./modules/automount.nix
            ./modules/bluetooth.nix
            ./modules/gaming.nix
            ./modules/fish.nix
            ./modules/network.nix
          ];
        };
        wsl = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs system; };

          modules = [
            nixos-wsl.nixosModules.default
            ./hosts/wsl/configuration.nix
            ./modules/defaults.nix
            ./modules/podman.nix
            ./modules/fish.nix
          ];
        };
      };

    };
}
