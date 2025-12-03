{ pkgs, ... }:

{
  home.packages = with pkgs; [ gopass expect gnupg pinentry-tty ];
  home.file.".gnupg/gpg-agent.conf".text = ''
    pinentry-program /home/nixy/.nix-profile/bin/pinentry
  '';
}
