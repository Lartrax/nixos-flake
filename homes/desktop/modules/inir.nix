{ inputs, pkgs, ... }:

{
  imports = [
    inputs.inir.homeModules.inir
  ];

  programs.inir = {
    enable = true;
    service.compositor = "niri";
    extraPackages = [ pkgs.niri ];
    configSymlink.enable = true;
  };

  home.packages = with pkgs; [
    quickshell
    kdePackages.syntax-highlighting
    kdePackages.kirigami
    kdePackages.kdialog
    kdePackages.plasma-browser-integration
    kdePackages.plasma-integration
    kdePackages.breeze-icons
    wl-clipboard
    cliphist
    grim
    slurp
    python314Packages.materialyoucolor
    darkly
    bc
    coreutils
    wget
    ripgrep
    jq
    python314
    xdg-user-dirs
    xdg-utils
    libnotify
    wlsunset
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-gnome
    polkit
    polkit_gnome
    networkmanager
    gnome-keyring
    gum
    xwayland-satellite
    qt6.qtbase
    qt6.qtsvg
    qt6.qtwayland
    qt6.qt5compat
    qt6.qtimageformats
    qt6.qtmultimedia
    qt6.qtpositioning
    qt6.qtquicktimeline
    qt6.qtsensors
    qt6.qttools
    qt6.qttranslations
    qt6.qtvirtualkeyboard
    qt6Packages.qt6ct
    jemalloc
    libdrm
    mesa
    playerctl
    libdbusmenu-gtk3
    mpv
    mpvScripts.mpris
    socat
    cava
    easyeffects
    swappy
    wf-recorder
    imagemagick
    ffmpeg
    upower
    wtype
    ydotool
    python314Packages.evdev
    python314Packages.pillow
    ddcutil
    geoclue2
    swayidle
    swaylock
    blueman
    libqalculate
    fontconfig
  ];
}
