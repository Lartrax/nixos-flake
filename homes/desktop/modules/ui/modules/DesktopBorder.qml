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
    layer.samples: 8
    layer.smooth: true

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

  // glass base
  Item {
    id: glassSource
    anchors.fill: parent
    visible: false
    layer.enabled: true
    layer.samples: 8
    layer.smooth: true

    Rectangle {
      anchors.fill: parent
      color: "#aaffffff"
    }
  }

  // cutout effect
  MultiEffect {
    anchors.fill: parent
    source: glassSource
    layer.smooth: true

    maskEnabled: true
    maskSource: maskCutout
    maskInverted: true

    maskThresholdMin: 0.9
    maskThresholdMax: 1.0
    maskSpreadAtMin: 0.0
    maskSpreadAtMax: 1.0
  }

  // border
  Shape {
    anchors.fill: parent
    layer.enabled: true
    layer.samples: 8
    layer.smooth: true

    ShapePath {
      strokeColor: "#bbffffff"
      strokeWidth: 1.5
      fillColor: "#00000000"

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

  // shadow mask/source
  Rectangle {
    id: shadowSource
    anchors {
      top: parent.top
      left: parent.left
      right: parent.right
      bottom: parent.bottom
      margins: 8
      leftMargin: 54
    }
    radius: 24
    color: "#00ffffff"
    visible: false
    layer.enabled: true
    layer.samples: 8
  }

  // shadow effect
  MultiEffect {
    id: innerShadow
    anchors.fill: shadowSource
    source: shadowSource

    shadowEnabled: true
    shadowColor: "#ff000000"
    shadowBlur: 0.9
    shadowHorizontalOffset: 0
    shadowVerticalOffset: 3

    maskEnabled: true
    maskSource: shadowSource
    maskInverted: true
    maskThresholdMin: 0.0
    maskThresholdMax: 1.0
  }
}
