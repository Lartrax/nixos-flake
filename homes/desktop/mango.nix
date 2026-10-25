{ pkgs, ... }:

{
  imports = [
    ./modules/awww.nix
    ./modules/catppuccin-cursors.nix
    ./modules/vicinae.nix
  ];

  home.file.".config/mango/config.conf" = {
    source = ./dots/config.conf;
  };

  # wayland.windowManager.mango = {
    # enable = true;

    # extraConfig = builtins.readFile ./dots/config.conf;
  # };
}
