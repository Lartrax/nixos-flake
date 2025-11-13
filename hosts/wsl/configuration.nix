{ inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = { nixy = import ../../homes/wsl.nix; };
  };

  users.users.nixy = {
    isNormalUser = true;
    description = "";
    extraGroups = [ "networkmanager" "wheel" "podman" ];
  };

  wsl.enable = true;
  wsl.defaultUser = "nixy";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
