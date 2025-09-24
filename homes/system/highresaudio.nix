{ ... }:

{
  home.file.".config/pipewire/pipewire.conf".text = ''
    default.clock.allowed-rates = [ 44100 48000 88200 96000 176400 192000 352800 384000 ]
  '';
}
