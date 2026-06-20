import Quickshell
import QtQuick
import QtQuick.Shapes

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

  Item {
    anchors.left: parent.left
    anchors.bottom: parent.bottom

    ClockWidget {
      anchors.centerIn: parent
    }
  }
}
