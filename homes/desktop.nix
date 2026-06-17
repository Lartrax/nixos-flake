{ ... }:

{
  imports = [
    ./desktop/hyprland.nix

    ./apps/brave.nix
    ./apps/dolphin.nix
    ./apps/foot.nix
    ./apps/easyeffects.nix
    ./apps/dolphin-emu.nix

    ./cli-tools/fastfetch.nix
    ./cli-tools/git.nix
    ./cli-tools/lazygit.nix
    ./cli-tools/neovim.nix
    ./cli-tools/btop-cuda.nix
    ./cli-tools/java-jdk-21.nix

    ./system/keyboard-layouts/hdc.nix
  ];

  home.username = "nixy";
  home.homeDirectory = "/home/nixy";

  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
}
