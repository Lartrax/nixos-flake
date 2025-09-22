{ config, pkgs, ... }:

let
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    # networkmanagerapplet
    ${pkgs.networkmanagerapplet}/bin/nm-applet --indicator &

    ${pkgs.waybar}/bin/waybar &

    # notification daemon
    ${pkgs.mako}/bin/mako &

    # set wallpaper
    ${pkgs.swww}/bin/swww img ${./wallpaper.png} &

    # start wallpaper daemon
    ${pkgs.swww}/bin/swww-daemon
  '';
in {
  home.username = "nixy";
  home.homeDirectory = "/home/nixy";

  # targets.genericLinux.enable = true; # ENABLE THIS ON NON NIXOS

  home.packages = [
    # pkgs.hell
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    XKB_DEFAULT_RULES = "${config.xdg.configHome}/xkb";
    XKB_DEFAULT_LAYOUT = "hdc";
  };

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

  home.stateVersion = "25.05";

  home.keyboard = null;

  programs.git = {
    enable = true;
    userName = "Lartrax";
    userEmail = "lartrax909@gmail.com";
    extraConfig = { init.defaultBranch = "main"; };
  };

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      # Autostart
      exec-once = "${startupScript}/bin/start";

      # Monitors
      monitor = ",preferred,auto,auto";

      # Programs
      "$terminal" = "kitty";
      "$fileManager" = "dolphin";
      "$menu" = "rofi -show drun -show-icons";

      # Environment variables
      env = [
        "GTK_THEME,Catppuccin-Dark-Frappe"
        "CURSOR_THEME,catppuccin-frappe-dark-cursors"
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
        "GDK_BACKEND,wayland,x11"
        "QT_QPA_PLATFORM,wayland;xcb"
        "SDL_VIDEODRIVER,wayland"
        "CLUTTER_BACKEND,wayland"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "QT_QPA_PLATFORMTHEME,qt5ct"
        "LIBVA_DRIVER_NAME,nvidia"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "GBM_BACKEND,nvidia-drm"
      ];

      # Look and feel
      general = {
        gaps_in = 2;
        gaps_out = 7;
        border_size = 2;

        "col.active_border" = "rgba(D75BC1ff) rgba(EB9592ff) 45deg";
        "col.inactive_border" = "rgba(C49AE5ff) rgba(C89DE6ff) 45deg";

        resize_on_border = true;

        layout = "dwindle";
      };

      group = {
        "col.border_active" = "rgba(DC7BC1ff) rgba(EB9592ff) 45deg";
        "col.border_inactive" = "rgba(C49AE5ff) rgba(C89DE6ff) 45deg";
        "col.border_locked_active" = "rgba(FFFFFFff) rgba(FFFFFFff) 45deg";
        "col.border_locked_inactive" = "rgba(FFFFFFcc) rgba(FFFFFFcc) 45deg";
      };

      decoration = {
        rounding = 10;

        # Change transparency of focused and unfocused windows
        active_opacity = 0.9;
        inactive_opacity = 0.85;

        shadow = {
          enabled = true;
          ignore_window = true;
          range = 14;
          render_power = 2;
          color = "rgba(FFFFFF80)";
          offset = "0 0";
        };

        blur = {
          enabled = true;
          size = 4;
          passes = 4;
          noise = 2.0e-2;
          new_optimizations = true;
          ignore_opacity = true;
          xray = false;
        };
      };

      layerrule = [ "blur,waybar" "blurpopups,waybar" "blur,rofi" "blur,mako" ];

      animations = {
        enabled = true;
        # Just use default curves
      };

      dwindle = {
        # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        pseudotile = true;
        preserve_split = true;
      };

      master = { new_status = "master"; };

      misc = {
        force_default_wallpaper = 2;
        disable_splash_rendering = true;
      };

      # Input
      input = {
        kb_layout = "no,hdc";
        kb_options = "grp:alt_shift_toggle";

        follow_mouse = 1;

        sensitivity = 0; # Default
      };

      # Keybinds
      "$mainMod" = "SUPER";
      bind = [
        "$mainMod, C, killactive,"
        "$mainMod, delete, exit,"
        "$mainMod, F, togglefloating,"
        "ALT, return, fullscreen,"
        "$mainMod, J, togglesplit,"
        # "$mainMod, P, pseudo,"

        "$mainMod, Q, exec, $terminal"
        "$mainMod, E, exec, $fileManager"
        "CTRL, space, exec, $menu"
        "$mainMod, L, exec, hyprlock"
        # Dismiss notification
        "$mainMod, R, exec, makoctl dismiss"
        # Screenshot snippet
        ''$mainMod, S, exec, grim -g "$(slurp -w 0)" - | satty -f - -o''

        # Move focus with mainMod + arrow keys
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Example special workspace (scratchpad)
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        # Move windows with mainMod + SHIFT + h/j/k/l
        "$mainMod SHIFT, j, movewindow, u"
        "$mainMod SHIFT, k, movewindow, d"
        "$mainMod SHIFT, h, movewindow, l"
        "$mainMod SHIFT, l, movewindow, r"

        # Resize window
        "$mainMod ALT, right, resizeactive, 24 0"
        "$mainMod ALT, left, resizeactive, -24 0"
        "$mainMod ALT, up, resizeactive, 0 -24"
        "$mainMod ALT, down, resizeactive, 0 24"

        # Move workspace to monitor
        "$mainMod SHIFT ALT, h, movecurrentworkspacetomonitor, -1"
        "$mainMod SHIFT ALT, l, movecurrentworkspacetomonitor, 1"
      ];

      bindm = [
        # Move/resize windows with mainMod + LMB/RMB and dragging
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      # Windows and workspaces
      windowrule = [
        # Ignore maximize requests from apps
        "suppressevent maximize, class:.*"
        # Fix some dragging issues with XWayland
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];
    };
  };

  programs.home-manager.enable = true;
}
