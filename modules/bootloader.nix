{ ... }:

{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 0;
    };
    kernelParams =
      [ "quiet" "loglevel=3" "systemd.show_status=auto" "rd.udev.log_level=3" ];
  };

  systemd.services = {
    systemd-udev-settle.enable = false;
    NetworkManager-wait-online.enable = false;
  };

  networking = {
    dhcpcd.enable = false;
    useNetworkd = true;
  };

  nix.gc.randomizedDelaySec = 600;

  fileSystems."/".autoResize = false;
  fileSystems."/".options = [ "noatime" ];
  fileSystems."/boot".autoResize = false;
}
