{ pkgs, ... }:

{
  programs.gamemode.enable = true;

  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (pkgs.lib.getName pkg) [
      "steam"
      "steam-unwrapped"
      "steamcmd"
    ];

  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin steamcmd ];
  };
}
