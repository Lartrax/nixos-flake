{ pkgs, config, ... }:

{
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (pkgs.lib.getName pkg) [
      "nvidia-x11"
      "nvidia-settings"
      "nvidia-persistenced"
    ];

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    # Required
    modesetting.enable = true;
    # Nvidia power management, experimental
    # Enable if you have gpu related issues after waking up from sleep
    # Saves entire VRAM to /tmp/ instead of just the bare essentials
    powerManagement.enable = false;
    # Turns off gpu when not in use, experimental
    powerManagement.finegrained = false;
    # Use the Nvidia open source kernel module
    open = true;
    # Enable the Nvidia settings menu
    nvidiaSettings = true;
    # Select driver version
    package = let
      base = config.boot.kernelPackages.nvidiaPackages.latest;
      cachyos-nvidia-patch = pkgs.fetchpatch {
        url =
          "https://raw.githubusercontent.com/CachyOS/CachyOS-PKGBUILDS/master/nvidia/nvidia-utils/kernel-6.19.patch";
        sha256 = "sha256-YuJjSUXE6jYSuZySYGnWSNG5sfVei7vvxDcHx3K+IN4=";
      };

      driverAttr = if config.hardware.nvidia.open then "open" else "bin";
    in base // {
      ${driverAttr} = base.${driverAttr}.overrideAttrs (oldAttrs: {
        patches = (oldAttrs.patches or [ ]) ++ [ cachyos-nvidia-patch ];
      });
    };
  };

  environment.sessionVariables = {
    "LIBVA_DRIVER_NAME" = "nvidia";
    "__GLX_VENDOR_LIBRARY_NAME" = "nvidia";
    "GBM_BACKEND" = "nvidia-drm";
  };
}
