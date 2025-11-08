{ ... }:

{
  imports = [
    ./desktop/hyprland.nix

    ./apps/brave.nix
    ./apps/dolphin.nix
    ./apps/kitty.nix

    ./cli-tools/fastfetch.nix
    ./cli-tools/git.nix
    ./cli-tools/lazygit.nix
    ./cli-tools/neovim.nix
    ./cli-tools/brightnessctl.nix

    ./system/keyboard-layouts/hdc.nix
  ];

  home.username = "nixy";
  home.homeDirectory = "/home/nixy";

  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
}
