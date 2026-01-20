{ inputs, pkgs, ... }:

{
  imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  nixpkgs.config.allowUnfree = true;

  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;

    servers.large-terrain = {
      enable = true;
      autoStart = false;
      serverProperties = {
        difficulty = "hard";
        gamemode = "survival";
        max-players = 300;
        motd = "Server A Minecraft";

        simulation-distance = 10;
        view-distance = 16;

        spawn-protection = 0;
        sync-chunk-writes = false;
        enable-command-block = false;
      };
      jvmOpts = [
        "-Xms30G"
        "-Xmx30G"
        "-XX:+UseZGC"
        "-XX:+ZUncommit"
        "-XX:+AlwaysPreTouch"
      ];
      package = pkgs.fabricServers.fabric-1_21_11;
      symlinks = {
        "mods" = pkgs.linkFarmFromDrvs "mods" (builtins.attrValues {
          FabricAPI = pkgs.fetchurl {
            url =
              "https://cdn.modrinth.com/data/P7dR8mSH/versions/DdVHbeR1/fabric-api-0.141.1%2B1.21.11.jar";
            sha256 = "ald/g72LM8lAQSfRZTGsycQZX0feA5WVfJ1M0J17mMY=";
          };
          C2ME = pkgs.fetchurl {
            url =
              "https://cdn.modrinth.com/data/VSNURh3q/versions/olrVZpJd/c2me-fabric-mc1.21.11-0.3.6.0.0.jar";
            sha256 = "1zyx643gaj6dvlaw6d1z4zgyrrja0ds0gag5jzqwvk2zc0sqs18g";
          };
          Chunky = pkgs.fetchurl {
            url =
              "https://cdn.modrinth.com/data/fALzjamp/versions/1CpEkmcD/Chunky-Fabric-1.4.55.jar";
            sha256 = "M8vZvODjNmhRxLWYYQQzNOt8GJIkjx7xFAO77bR2vRU=";
          };
          ClothConfig = pkgs.fetchurl {
            url =
              "https://cdn.modrinth.com/data/9s6osm5g/versions/xuX40TN5/cloth-config-21.11.153-fabric.jar";
            sha256 = "ikDITl7N5SWs+2xOE7gALaz8o++VNNf69ugEllb0I8g=";
          };
          CristelLib = pkgs.fetchurl {
            url =
              "https://cdn.modrinth.com/data/cl223EMc/versions/6vtzWpRI/cristellib-fabric-1.21.11-3.0.4.jar";
            sha256 = "nL2JkmtC0Y5n4DsDHditttlBd80sUVBTF34nxW47Lpg=";
          };
          FerriteCore = pkgs.fetchurl {
            url =
              "https://cdn.modrinth.com/data/uXXizFIs/versions/eRLwt73x/ferritecore-8.0.3-fabric.jar";
            sha256 = "yG6rrNvwY5ibLKgSyOk/VWuP7/HJ38B8rvodkKXHvzU=";
          };
          Lithium = pkgs.fetchurl {
            url =
              "https://cdn.modrinth.com/data/gvQqBUqZ/versions/gl30uZvp/lithium-fabric-0.21.2%2Bmc1.21.11.jar";
            sha256 = "MQZjnHPuI/RL++Xl56gVTf460P1ISR5KhXZ1mO17Bzk=";
          };
          Lithostitched = pkgs.fetchurl {
            url =
              "https://cdn.modrinth.com/data/XaDC71GB/versions/FPDWwi24/lithostitched-1.5.7-fabric-1.21.11.jar";
            sha256 = "5ZqCkIIB26xV14Q+VrpXt9HahBHoXuLbWQcqfW82M94=";
          };
          ScalableLux = pkgs.fetchurl {
            url =
              "https://cdn.modrinth.com/data/Ps1zyz6x/versions/PV9KcrYQ/ScalableLux-0.1.6%2Bfabric.c25518a-all.jar";
            sha256 = "ekpzcThhg8dVUjtWtVolHXWsLCP0Cvik8PijNbBdT8I=";
          };
          Tectonic = pkgs.fetchurl {
            url =
              "https://cdn.modrinth.com/data/lWDHr9jE/versions/7olSYFxL/tectonic-3.0.19-fabric-1.21.11.jar";
            sha256 = "p0WQfF8uX9saB4b6Ms4AoDiQ4w8bh+bA6hDKoH3CmtY=";
          };
          Terralith = pkgs.fetchurl {
            url =
              "https://cdn.modrinth.com/data/8oi3bsk5/versions/TFW9ZxPQ/Terralith_1.21.x_v2.5.14.jar";
            sha256 = "3mLFiOb5f+KgkjyQVBuRYv7MoPX9h6uusJpevlQg238=";
          };
          WWOO = pkgs.fetchurl {
            url =
              "https://cdn.modrinth.com/data/II7t6llZ/versions/efhudKpb/wwoo-fabric-2.6.2.jar";
            sha256 = "xMXUTeKpO4q0U6ojOM+hdU9S/0S6hh2cIb5RwB+zWGQ=";
          };
          Krypton = pkgs.fetchurl {
            url =
              "https://cdn.modrinth.com/data/fQEb0iXm/versions/O9LmWYR7/krypton-0.2.10.jar";
            sha256 = "lCkdVpCgztf+fafzgP29y+A82sitQiegN4Zrp0Ve/4s=";
          };
        });
      };
    };
  };
}
