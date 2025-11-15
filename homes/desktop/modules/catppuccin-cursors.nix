{ pkgs, ... }:

{
  home.packages = with pkgs; [ catppuccin-cursors.frappeDark ];
}
