{ pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [ nerd-fonts.monaspace source-han-sans ];

    fontconfig = {
      defaultFonts = {
        serif = [ "MonaspiceXe Nerd Font Propo" ];
        sansSerif = [ "MonaspiceNe Nerd Font Propo" "Source Han Sans" ];
        monospace = [ "MonaspiceAr Nerd Font Propo" ];
      };
    };
  };
}
