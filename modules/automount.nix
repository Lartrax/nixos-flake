{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ android-file-transfer ];

  boot.supportedFilesystems = [ "ntfs" ];
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
}
