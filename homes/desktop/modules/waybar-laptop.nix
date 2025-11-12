{ pkgs, ... }:

{
  home.packages = with pkgs; [ waybar ];

  home.file.".config/waybar/style.css".text = ''
    @define-color bar-bg rgba(14, 14, 14, 0.02);

    @define-color main-color rgba(255, 255, 255, 0.8);
    @define-color main-bg rgba(14, 14, 14, 0);
    @define-color dark #292828;

    @define-color tool-bg #292828;
    @define-color tool-color #D9D0E3;
    @define-color tool-color-alt #DDDDEE;
    @define-color tool-border #383432;

    @define-color wb-color #a89984;

    @define-color wb-act-bg #7c6f64;
    @define-color wb-act-color #504945;

    @define-color wb-hvr-bg rgba(216, 166, 87, 0.1);
    @define-color wb-hvr-color #5a524c;

    * {
    	border: none;
    	border-radius: 0px;
    	font-family: "MonaspiceAr Nerd Font Propo";
    	font-weight: bold;
    }

    .modules-right {
    	background: @main-bg;
    	padding-left: 16px;
      padding-right: 16px;
    }

    window#waybar {
    	background: @bar-bg;
      border-radius: 24px;
      border: solid 1px;
      border-color: @wb-hvr-bg;
    }

    tooltip {
    	background: @bar-bg;
    	color: @tool-color;
    	border-radius: 16px;
    	padding: 16px;
    }

    #workspaces {
    	padding-left: 16px;
    	padding-right: 16px;
    	background: @main-bg;
    	border-radius: 0px 24px 24px 0px;
    }

    #workspaces button {
    	font-size: 18px;
    	box-shadow: none;
    	text-shadow: none;
    	padding: 0px;
    	min-width: 32px;
    	color: @tool-color;
    	transition: all 0.2s cubic-bezier(0.55, -0.68, 0.48, 1.682);
    	opacity: 0.9;
    }

    #workspaces button.active {
    	color: @tool-color-alt;
    	transition: all 0.2s cubic-bezier(0.55, -0.68, 0.48, 1.682);
    	opacity: 0.95;
    }

    #workspaces button:hover {
    	color: @wb-hvr-color;
    	transition: all 0.2s cubic-bezier(0.55, -0.68, 0.48, 1.682);
    	opacity: 1;
    }

    #cpu,
    #battery,
    #memory,
    #clock,
    #window,
    #network,
    #bluetooth,
    #pulseaudio,
    #mpris,
    #custom-updates,
    #custom-wallchange,
    #custom-mode,
    #custom-cliphist,
    #custom-wbar,
    #custom-power,
    #tray {
    	font-size: 14px;
    	color: @main-color;
    	padding-left: 12px;
    	padding-right: 12px;
    }

    #cpu {
      font-size: 8px;
    }

    #memory {
      font-size: 20px;
      padding-bottom: 4px;
    }

    #window,
    #taskbar {
    	padding: 0px;
    }

    #custom-seperator {
      color: @tool-color;
      font-size: 28px;
      opacity: 0.1;
      padding-left: 12px;
      padding-right: 12px;
    }

    #battery {
      font-size: 16px;
    }
  '';

  home.file.".config/waybar/config.jsonc".text = ''
    {
    	"layer": "top",
    	"position": "top",
    	"mod": "dock",
    	"exclusive": true,
    	"passthrough": false,
    	"gtk-layer-shell": true,
      "margin": "6px 8px 3px 8px",

        "modules-left": ["hyprland/workspaces"],
        // "modules-center": ["wlr/taskbar"],
        "modules-right": ["memory", "cpu", "custom/seperator", "network", "battery", "custom/seperator", "clock"],

    	"cpu": {
        "rotate": 90,
        "interval": 10,
    		"format": "{icon0} {icon1}\n{icon2} {icon3}\n{icon4} {icon5}",
    		"format-icons": ["▫", "▪", "□", "▣", "■"]
    	},

    	"memory": {
    		"interval": 30,
    		"format": "{icon}",
    		"format-icons": ["░░", "▒░", "▒▒", "▓▒", "▓▓", "█▓", "██"],
    		"max-length": 10,
    		"tooltip": true,
    		"tooltip-format": "{used:0.1f}GB/{total:0.1f}GB"
    	},

    	"clock": {
    		"format": "{:%H:%M}",
    		"format-alt": "{:%H:%M %D}",
    		"tooltip-format": "{calendar}"
    	},

    	"hyprland/workspaces": {
    		"format": "{icon}",
    		"on-click": "activate",
    		"format-icons": {
    			"1": "一",
    			"2": "二",
    			"3": "三",
    			"4": "四",
    			"5": "五",
    			"6": "六",
    			"7": "七",
    			"8": "八",
    			"9": "九",
    			"10": "十"
    		},
    		"sort-by-number": true
    	},

    	"wlr/taskbar": {
    		"format": "{icon}",
    		"icon-size": 24,
    		"icon-theme": "Adwaita",
    		"tooltip-format": "{title}",
    		"on-click": "activate",
    		"on-click-middle": "close",
    		"ignore-list": ["kitty"],
    		"app_ids-mapping": {
    		// "firefoxdeveloperedition": "firefox-developer-edition"
    		}
    	},

      "network": {
        "format-wifi": "",
        "format-ethernet": "",
        "tooltip-format-wifi": "{essid} {signalStrength}%",
        "tooltip-format": "{ifname} via {gwaddr} ",
        "format-disconnected": "⚠",
        "format-alt": "{ifname}: {ipaddr}/{cidr}"
      },

      "custom/seperator": {
        "format": "│",
        "tooltip-format": ""
      },

      "battery": {
        "rotate": 270,
        "interval": 60,
        "states": {
          "warning": 30,
          "critical": 15
        },
        "events": {
          "on-discharging-warning": "notify-send -u normal 'Low Battery'",
          "on-discharging-critical": "notify-send -u critical 'Very Low Battery'",
          "on-charging-100": "notify-send -u normal 'Battery Full!'"
        },
        "format": "{icon}",
        "format-charging": "󰂄",
        "format-plugged": "{icon}",
        "tooltip-format": "{capacity}%",
        "format-icons": ["󰁺", "󰁻", "󰁼", "󰁽", "󰁾", "󰁿", "󰂀", "󰂁", "󰂂", "󰁹"],
        "max-length": 25
      }
    }
  '';
}
