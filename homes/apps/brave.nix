{ pkgs, ... }:

{
  # nixpkgs.config.allowUnfreePredicate = pkg:
  #   builtins.elem (pkgs.lib.getName pkg) [ "castlabs-electron" ];

  home.packages = with pkgs; [ brave ];
}
