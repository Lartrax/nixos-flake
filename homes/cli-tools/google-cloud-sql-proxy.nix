{ pkgs, ... }:

{
  home.packages = with pkgs; [ google-cloud-sql-proxy ];
}
