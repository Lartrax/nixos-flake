{ pkgs, ... }:

{
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (pkgs.lib.getName pkg) [ "parsec-bin" ];

  home.packages = with pkgs; [ parsec-bin ];
}
