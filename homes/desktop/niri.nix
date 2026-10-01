{ pkgs, ... }:

{
  imports = [
    ./modules/awww.nix
    ./modules/networkmanagerapplet.nix
    ./modules/catppuccin-cursors.nix
    ./modules/inir.nix
  ];

  wayland.windowManager.niri = {
    enable = true;

    extraConfig = builtins.readFile ./dots/config.kdl;
  };
}
