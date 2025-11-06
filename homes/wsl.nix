{ ... }:

{
  imports = [
    ./cli-tools/fastfetch.nix
    ./cli-tools/git.nix
    ./cli-tools/lazygit.nix
  ];

  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
}
