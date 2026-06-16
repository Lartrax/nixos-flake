import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Shapes

PanelWindow {
  id: root
  exclusionMode: ExclusionMode.Ignore
  aboveWindows: true
  WlrLayershell.namespace: "quickshell-border-shadow"

  anchors {
    top: true
    left: true
    right: true
    bottom: true
  }

  mask: Region{}

  color: "#00000000"

  // cutout
  Shape {
    id: maskCutout
    anchors.fill: parent
    visible: false
    layer.enabled: true

    ShapePath {
      fillColor: "#ff000000"

      startX: 54;
      startY: 8 + 24;
      PathLine { x: 54; y: root.height - 8 - 24 }
      PathArc {
        x: 54 + 24; y: root.height - 8
        radiusX: 24; radiusY: 24
        direction: PathArc.Counterclockwise
      }
      PathLine { x: root.width - 8 - 24; y: root.height - 8 }
      PathArc {
        x: root.width - 8; y: root.height - 8 - 24
        radiusX: 24; radiusY: 24
        direction: PathArc.Counterclockwise
      }
      PathLine { x: root.width - 8; y: 8 + 24 }
      PathArc {
        x: root.width - 8 - 24; y: 8
        radiusX: 24; radiusY: 24
        direction: PathArc.Counterclockwise
      }
      PathLine { x: 54 + 24; y: 8 }
      PathArc {
        x: 54; y: 8 + 24
        radiusX: 24; radiusY: 24
        direction: PathArc.Counterclockwise
      }
    }
  }

  // shadow
  MultiEffect {
    id: innerShadow
    anchors.fill: maskCutout
    source: maskCutout
    visible: false

    shadowEnabled: true
    shadowColor: "#33000000"
    shadowBlur: 1.0
    shadowHorizontalOffset: 0
    shadowVerticalOffset: 10

    // blurMax: 10
    // blurMultiplier: 10
  }

  // shadow cut
  MultiEffect {
    anchors.fill: maskCutout
    source: innerShadow

    maskEnabled: true
    maskSource: maskCutout
    maskInverted: true

    maskThresholdMin: 0.0
    maskThresholdMax: 1.0
    maskSpreadAtMin: 0.0
    maskSpreadAtMax: 1.0
  }
}
