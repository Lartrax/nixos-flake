{ pkgs, ... }:

{
  home.packages = with pkgs; [ git ];

  programs.git = {
    enable = true;
    settings = {
      user.name = "Lartrax";
      user.email = "lartax909@gmail.com";
      credential.helper = "cache --timeout=2592000"; # Cache for 30 days
      init.defaultBranch = "main";
    };
  };
}
