{ pkgs, ... }:

{
  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    package = pkgs.catppuccin-cursors.latteDark;
    name = "catppuccin-latte-dark-cursors";
    size = 24;
  };
}
