import Quickshell
import QtQuick
import QtQuick.Shapes
import QtQuick.Effects

import "../widgets"

Item {
  id: root
  anchors {
    left: parent.left
    bottom: parent.bottom
  }

  implicitHeight: parent.height / 2
  implicitWidth: parent.width / 2

  // bottom left glass frame
  Shape {
    id: glass
    anchors.fill: parent
    visible: false
    layer.enabled: true

    ShapePath {
      fillColor: "#aaffffff"
      strokeColor: "#00000000"

      startX: 56;
      startY: 0;
      PathLine { relativeX: 0; y: root.height - 32 }
      PathArc {
        relativeX: 24; relativeY: 24
        radiusX: 24; radiusY: 24
        direction: PathArc.Counterclockwise
      }
      PathLine { x: root.width; relativeY: 0 }
      PathLine { relativeX: 0; y: root.height }
      PathLine { x: 0; relativeY: 0 }
      PathLine { relativeX: 0; y: 0 }
    }
  }

  // glass border
  Shape {
    id: border
    anchors.fill: parent
    layer.enabled: true
    layer.samples: 4
    layer.smooth: true

    ShapePath {
      fillColor: "#00000000"
      strokeColor: "#ccffffff"
      strokeWidth: 1.5

      startX: 56;
      startY: 0;
      PathLine { relativeX: 0; y: root.height - 32 }
      PathArc {
        relativeX: 24; relativeY: 24
        radiusX: 24; radiusY: 24
        direction: PathArc.Counterclockwise
      }
      PathLine { x: root.width; relativeY: 0 }
    }
  }

  // clock cutout
  MultiEffect {
    anchors.fill: parent
    source: glass

    maskEnabled: true
    maskSource: clockMask
    maskInverted: true

    maskThresholdMin: 0.5
    maskThresholdMax: 1.0
    maskSpreadAtMin: 1.0
    maskSpreadAtMax: 0.0
  }

  Item {
    id: menu
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.bottom: parent.bottom

    implicitWidth: 56

    // Rectangle {
    //   anchors.fill: parent
    //   color: "#aaff0000"
    // }

    Rectangle {
      id: optionsPill
      anchors.left: parent.left
      anchors.right: parent.right
      anchors.bottom: clockMask.top
      anchors.margins: 8

      implicitHeight: 72

      color: "#55ffffff"
      border.color: "#aaffffff"
      border.width: 1.0
      radius: 24

      Column {
        anchors.centerIn: parent
        spacing: 4

        Text {
          text: "󰤥"
          font.pixelSize: 20
        }
        Text {
          text: "󰤥"
          font.pixelSize: 20
        }
      }
    }

    Item {
      id: clockMask
      anchors.left: parent.left
      anchors.right: parent.right
      anchors.bottom: parent.bottom
      anchors.bottomMargin: 32

      implicitHeight: clock.height

      visible: false
      layer.enabled: true

      ClockWidget {
        id: clock
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        color: "#aaffffff"
        font.pixelSize: 20
      }
    }
  }
}
