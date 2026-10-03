{ pkgs, ... }:

{
  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    package = pkgs.catppuccin-cursors.frappeDark;
    name = "catppuccin-frappe-dark-cursors";
    size = 24;
  };
}
