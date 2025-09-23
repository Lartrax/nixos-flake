{ pkgs, ... }:

{
  home.packages = with pkgs; [ hyprlock ];

  home.file.".config/hypr/hyprlock.conf".text = ''
    $font = MonaspiceAr Nerd Font Propo

    general {
        hide_cursor = false
    }

    animations {
        enabled = true
        bezier = linear, 1, 1, 0, 0
        animation = fadeIn, 1, 5, linear
        animation = fadeOut, 1, 5, linear
        animation = inputFieldDots, 1, 2, linear
    }

    background {
        monitor =
        path = screenshot
        blur_passes = 3
    }

    input-field {
        monitor =
        size = 20%, 5%
        outline_thickness = 3
        inner_color = rgba(0, 0, 0, 0.0) # no fill

        outer_color = rgba(D75BC1ff) rgba(EB9592ff) 45deg
        inner_color = rgba(D9D0E3B3)
        check_color = rgba(3A436B80) rgba(CCD5FFe6) 60deg
        fail_color = rgba(E71B81ff) rgba(FB5552ff) 120deg

        font_color = rgba(14, 14, 14, 0.2)
        fade_on_empty = false
        rounding = -1

        font_family = $font
        placeholder_text = Password
        fail_text = $PAMFAIL

        dots_spacing = 0.3
        dots_color = rgba(D9D0E3)

        position = 0, -20
        halign = center
        valign = center
    }

    label {
        monitor =
        text = $TIME # ref. https://wiki.hyprland.org/Hypr-Ecosystem/hyprlock/#variable-substitution
        font_size = 90
        font_family = $font

        position = -30, 0
        halign = right
        valign = top
    }

    label {
        monitor =
        text = cmd[update:60000] date +"%A, %d %B %Y" # update every 60 seconds
        font_size = 25
        font_family = $font

        position = -30, -150
        halign = right
        valign = top
    }
  '';
}
