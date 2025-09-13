{
  description = "My NixOS setup flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { self, nixpkgs, home-manager, hyprland }@inputs:
  let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;

      config = {
        allowUnFree = true;
      };
    };
  
  in
  {
 
  nixosConfigurations = {
    myNixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs system; };
 
       modules = [
        ./nixos/configuration.nix
      ];
    };
  };

  };
}
