{ ... }:

{
  imports = [
    ./cli-tools/fastfetch.nix
    ./cli-tools/git.nix
    ./cli-tools/lazygit.nix
    ./cli-tools/google-cloud-sdk.nix
  ];

  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
}
