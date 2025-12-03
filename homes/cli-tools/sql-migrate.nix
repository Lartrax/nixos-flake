{ pkgs, ... }:

{
  home.packages = with pkgs; [ sql-migrate ];
}
