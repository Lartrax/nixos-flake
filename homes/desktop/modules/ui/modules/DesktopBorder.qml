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
  anchors {
    top: true
    left: true
    right: true
    bottom: true
  }

  // implicitHeight: 48
  color: "#00000000"

  Shape {
    anchors.fill: parent

    ShapePath {
      strokeColor: "#ffff0000"
      strokeWidth: 2
      fillColor: "#00000000"

      startX: 54;
      startY: 8 + 24;
      PathLine { x: 54; y: root.height - 8 - 24 }
      PathArc {
        x: 54 + 24; y: root.height - 8
        radiusX: 24; radiusY: 24
      }
      PathLine { x: root.width - 8; y: root.height - 8 }
      PathLine { x: root.width - 8; y: 8 }
      PathLine { x: 54; y: 8 }
    }
  }

  // glass base
  Item {
    id: glassSource
    anchors.fill: parent
    visible: false
    layer.enabled: true

    Rectangle {
      anchors.fill: parent
      // anchors.topMargin: -border.width
      color: "#88ffffff"
      // border.color: "#99ffffff"
      // border.width: 1
    }
  }

  // border
  Rectangle {
    anchors.fill: parent
    anchors.margins: 8
    anchors.leftMargin: anchors.margins + 48

    bottomLeftRadius: 24
    bottomRightRadius: 24
    topLeftRadius: 24
    topRightRadius: 24

    color: "#00000000"

    border.color: "#aaffffff"
    border.width: 1.5
  }

  // cutout mask
  Item {
    id: maskRounded
    anchors.fill: parent
    visible: false
    layer.enabled: true

    Rectangle {
      anchors.fill: parent
      anchors.margins: 8
      anchors.leftMargin: anchors.margins + 48

      bottomLeftRadius: 24
      bottomRightRadius: 24
      topLeftRadius: 24
      topRightRadius: 24

      color: "#ffffffff"
    }
  }

  // cutout effect
  MultiEffect {
    anchors.fill: parent
    source: glassSource

    maskEnabled: true
    maskSource: maskRounded
    maskInverted: true

    maskThresholdMin: 0.9
    maskThresholdMax: 1.0
    maskSpreadAtMin: 0.0
    maskSpreadAtMax: 1.0
  }
}
