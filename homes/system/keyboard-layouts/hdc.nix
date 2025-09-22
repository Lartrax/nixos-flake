{ config, ... }:

{
  home.sessionVariables = {
    XKB_DEFAULT_RULES = "${config.xdg.configHome}/xkb";
    XKB_DEFAULT_LAYOUT = "hdc";
  };

  # TODO: remove ?
  home.keyboard = null;

  home.file.".config/xkb/symbols/hdc".text = ''
    default partial alphanumeric_keys
    xkb_symbols "basic" {
      name[Group1]= "HDC Layout";

      include "no(basic)"

      key <AE01> { [1, EuroSign] };
      key <AE02> { [2, dollar] };
      key <AE03> { [3, sterling] };
      key <AE04> { [4, currency] };
      key <AE05> { [5] };
      key <AE06> { [6] };
      key <AE07> { [7] };
      key <AE08> { [8] };
      key <AE09> { [9] };
      key <AE10> { [0] };
      key <AE11> { [] };
      key <AE12> { [] };

      key <AD01> { [j, J, asterisk] };
      key <AD02> { [g, G, ampersand] };
      key <AD03> { [m, M, bracketleft] };
      key <AD04> { [p, P, bracketright] };
      key <AD05> { [v, V] };
      key <AD06> { [numbersign, at, percent] };
      key <AD07> { [x, X] };
      key <AD08> { [z, Z, underscore] };
      key <AD09> { [q, Q, apostrophe] };
      key <AD10> { [aring, Aring] };
      key <AD11> { [ae, AE] };
      key <AD12> { [diaeresis, asciicircum, asciitilde] };

      key <AC01> { [r, R, slash] };
      key <AC02> { [s, S, quotedbl] };
      key <AC03> { [n, N, parenleft] };
      key <AC04> { [t, T, parenright] };
      key <AC05> { [b, B] };
      key <AC06> { [period, colon] };
      key <AC07> { [a, A, h, H] };
      key <AC08> { [e, E, j, J] };
      key <AC09> { [i, I, k, K] };
      key <AC10> { [h, H, l, L] };
      key <AC11> { [oslash, Ooblique] };
      key <AC12> { [exclam, question] };

      key <LSGT> { [f, F, less] };
      key <AB01> { [c, C, greater] };
      key <AB02> { [l, L, braceleft] };
      key <AB03> { [d, D, braceright] };
      key <AB04> { [w, W] };
      key <AB05> { [grave, backslash, acute] };
      key <AB06> { [comma, semicolon] };
      key <AB07> { [u, U, equal] };
      key <AB08> { [o, O, minus] };
      key <AB09> { [y, Y, plus] };
      key <AB10> { [k, K] };
    };
  '';
}
