{ pkgs, ... }:

{
  home.packages = with pkgs; [ git ];

  programs.git = {
    enable = true;
    userName = "Lartrax";
    userEmail = "lartrax909@gmail.com";
    extraConfig = { init.defaultBranch = "main"; };
  };
}
