{ pkgs, ... }:

{
  home.packages = with pkgs; [
    quickshell
  ];

  home.file.".config/quickshell" = {
    source = ./ui;
    recursive = true;
  };
}
