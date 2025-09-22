{ pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [ nerd-fonts.monaspace ];

    fontconfig = {
      defaultFonts = {
        serif = [ "MonaspiceXe Nerd Font Propo" ];
        sansSerif = [ "MonaspiceAr Nerd Font Propo" ];
        monospace = [ "MonaspiceNe Nerd Font Propo" ];
      };
    };
  };
}
