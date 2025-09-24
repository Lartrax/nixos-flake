{ pkgs, ... }:

{
  home.packages = with pkgs; [ mako libnotify ];

  home.file.".config/mako/config".text = ''
    font=MonaspiceAr Nerd Font Propo 11
    background-color=#D9D0E3DD
    text-color=#3A436B80
    width=300
    height=300
    border-color=#14141420
    border-radius=10
    border-size=1
    padding=8
    margin=12
    outer-margin=2
    progress-color=source #A7B9E1CC
  '';
}
