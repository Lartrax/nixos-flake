{ ... }:

{
  imports = [
    ./desktop/hyprland.nix

    ./apps/firefox.nix
    ./apps/dolphin.nix
    ./apps/kitty.nix
    ./apps/easyeffects.nix

    ./cli-tools/fastfetch.nix
    ./cli-tools/git.nix

    ./system/keyboard-layouts/hdc.nix
  ];

  home.username = "nixy";
  home.homeDirectory = "/home/nixy";

  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
}
