{ pkgs, ... }:

{
  imports = [
    ./modules/mako.nix
    ./modules/rofi-desktop.nix
    ./modules/awww.nix
    ./modules/hyprlock.nix
    ./modules/networkmanagerapplet.nix
    ./modules/catppuccin-cursors.nix
    ./modules/hyprsunset.nix
    ./modules/quickshell.nix
  ];

  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    extraConfig = builtins.readFile ./dots/hyprland.lua;
  };
}
