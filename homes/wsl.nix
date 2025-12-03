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
    ./cli-tools/bitwarden-cli.nix
    ./cli-tools/gopass.nix
    ./cli-tools/sql-migrate.nix
    ./cli-tools/gnumake.nix
  ];

  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
}
