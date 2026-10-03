{ pkgs, ... }:

{
  home.packages = with pkgs; [ fetch ];
}
