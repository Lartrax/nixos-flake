{ pkgs, ... }:

{
  home.packages = with pkgs; [ javaPackages.compiler.temurin-bin.jdk-21 ];
}
