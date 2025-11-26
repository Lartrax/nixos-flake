{ pkgs, ... }:

{
  home.packages = with pkgs; [ git ];

  programs.git = {
    enable = true;
    settings = {
      user.name = "Lartrax";
      user.email = "lartax909@gmail.com";
      credential.helper = "store";
      init.defaultBranch = "main";
      url = {
        "git@github.com:" = {
          insteadOf = "https://github.com";
        };
      };
    };
  };
}
