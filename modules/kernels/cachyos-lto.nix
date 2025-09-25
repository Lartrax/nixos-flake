{ pkgs, ... }:

{
  boot.kernelPackages =
    pkgs.linuxPackages_cachyos-lto.cachyOverride { mArch = "ZEN4"; };
}
