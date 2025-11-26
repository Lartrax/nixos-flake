{ ... }:

{
  imports = [
    ./cli-tools/fastfetch.nix
    ./cli-tools/git.nix
    ./cli-tools/lazygit.nix
    ./cli-tools/google-cloud-sdk.nix
    ./cli-tools/google-cloud-sql-proxy.nix
    ./cli-tools/terraform.nix
    ./cli-tools/go.nix
  ];

  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
}
