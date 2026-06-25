pragma Singleton

import Quickshell
import Quickshell.Services.Pipewire

Singleton {
  id: root

  readonly property PwNode sink:  Pipewire.defaultAudioSink
  readonly property PwNode source: Pipewire.defaultAudioSource

  readonly property bool sinkMuted: sink?.audio.muted ?? false
  readonly property real sinkVolume: sink?.audio.volume ?? 0.0
  readonly property bool sourceMuted: source?.audio.muted ?? false
  readonly property real sourceVolume: source?.audio.volume ?? 0.0

  PwObjectTracker {
    objects: [sink, source]
  }
}
