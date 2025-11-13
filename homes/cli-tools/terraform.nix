{ pkgs, ... }:

{
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (pkgs.lib.getName pkg) [ "terraform" ];

  home.packages = with pkgs; [ terraform ];
}
