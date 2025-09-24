{ config, ... }:

{
  # Enable OpenGL
  hardware.graphics.enable = true;

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
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  environment.sessionVariables = {
    "LIBVA_DRIVER_NAME" = "nvidia";
    "__GLX_VENDOR_LIBRARY_NAME" = "nvidia";
    "GBM_BACKEND" = "nvidia-drm";
  };
}
