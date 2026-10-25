{ pkgs, ... }:

{
  imports = [
    ./modules/awww.nix
    ./modules/catppuccin-cursors.nix
    ./modules/vicinae.nix
  ];

  home.file.".config/mango" = {
    source = ./dots/mango;
    recursive = true;
  };

  # wayland.windowManager.mango = {
    # enable = true;

    # extraConfig = builtins.readFile ./dots/config.conf;
  # };
}
