{ pkgs, ... }:

{
  home.packages = with pkgs; [ hyprsunset ];

  home.file.".config/hypr/hyprsunset.conf".text = ''
    profile {
      time = 7:30
    }

    profile {
      time = 21:00
      temperature = 2700
    }
  '';
}
