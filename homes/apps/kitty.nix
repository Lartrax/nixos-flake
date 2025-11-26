{ pkgs, ... }:

{
  home.packages = with pkgs; [ kitty ];

  home.file.".config/kitty/theme.conf".text = ''
    foreground              #060606
    background              #D9D0E3
    selection_foreground    #D9D0E3
    selection_background    #060606
    cursor                  #363A4C
    cursor_text_color       #FFFFFF

    active_tab_foreground     #D9D0E3
    active_tab_background     #928AA5
    inactive_tab_foreground   #928AA5
    inactive_tab_background   #D9D0E3

    # Black
    color0                #000000
    color8                #484848
    # Red
    color1                #CF1717
    color9                #F07575
    # Green
    color2                #17CF17
    color10               #75F075
    # Yellow
    color3                #CFCF17
    color11               #F0F075
    # Blue
    color4                #1717CF
    color12               #7575F0
    # Magenta
    color5                #CF17CF
    color13               #F075F0
    # Cyan
    color6                #17CFCF
    color14               #75F0F0
    # White
    color7                #EEEEEE
    color15               #FFFFFF
  '';

  home.file.".config/kitty/kitty.conf".text = ''
    include theme.conf
    window_padding_width 4
    font_family "Monaspace Neon Nerd Font"
  '';
}
