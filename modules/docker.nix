{ pkgs, ... }:

{
  virtualisation.docker = {
    enable = false;

    rootless = {
      enable = true;
      daemon.settings = {
        dns = [ "1.1.1.1" "8.8.8.8" ];
        registry-mirrors = [ "https://mirror.gcr.io" ];
      };
    };
  };
  environment.systemPackages = with pkgs; [ colima docker-compose ];
}
