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
in
{
  home.username = "nixy";
  home.homeDirectory = "/home/nixy";

  # targets.genericLinux.enable = true; # ENABLE THIS ON NON NIXOS

  home.packages = [
    pkgs.hello
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.file = {
  
  };

  home.stateVersion = "25.05";

  programs.git = {
    enable = true;
    userName = "Lartrax";
    userEmail = "lartrax909@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      # Autostart
      exec-once = ''${startupScript}/bin/start'';

      # Monitors
      monitor = ",preferred,auto,auto";

      # Programs
      "$terminal" = "kitty";
      "$fileManager" = "dolphin";
      "$menu" = "rofi -show drun -show-icons";

      # Environment variables
      env = [
        "XCURSOR_SIZE,24"
	"HYPRCURSOR_SIZE,24"
      ];

      # Look and feel
      general = {
        gaps_in = 5;
	gaps_out = 20;

	border_size = 2;

	"col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
	"col.inactive_border" = "rgba(595959aa)";

	resize_on_border = true;

	allow_tearing = false;

	layout = "dwindle";
      };

      decoration = {
        rounding = 10;
	rounding_power = 2;

	# Change transparency of focused and unfocused windows
	active_opacity = 1.0;
	inactive_opacity = 1.0;

	shadow = {
	  enabled = true;
	  range = 4;
	  render_power = 3;
	  color = "rgba(1a1a1aee)";
	};

	blur = {
	  enabled = true;
	  size = 3;
	  passes = 1;
	  vibrancy = 0.1696;
	};
      };

      animations = {
        enabled = true;
	# Just use default curves
      };

      dwindle = {
        pseudotile = true; # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
	preserve_split = true;
      };

      master = {
        new_status = "master";
      };

      misc = {
        disable_splash_rendering = true;
      };

      # Input
      input = {
        kb_layout = "no";

	follow_mouse = 1;

	sensitivity = 0; # Default
      };
     

      # Keybinds
      "$mainMod" = "SUPER";
      bind = [
	"$mainMod, Q, exec, $terminal"
	"$mainMod, C, killactive,"
	"$mainMod, M, exit,"
	"$mainMod, E, exec, $fileManager"
	"$mainMod, V, togglefloating,"
	"$mainMod, R, exec, $menu"
	"$mainMod, P, pseudo," # dwindle
	"$mainMod, J, togglesplit," # dwindle

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
