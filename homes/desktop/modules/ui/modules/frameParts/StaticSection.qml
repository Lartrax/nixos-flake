import Quickshell
import QtQuick
import QtQuick.Shapes

Item {
  id: root
  anchors.fill: parent

  // static glass frame
  Shape {
    id: glass
    anchors.fill: parent

    ShapePath {
      fillColor: "#aaffffff"
      strokeColor: "#00000000"

      startX: 56;
      startY: 0;
      PathLine { relativeX: 0; y: 32 }
      PathArc {
        relativeX: 24; relativeY: -24
        radiusX: 24; radiusY: 24
      }
      PathLine { x: root.width - 32; relativeY: 0 }
      PathArc {
        relativeX: 24; relativeY: 24
        radiusX: 24; radiusY: 24
      }
      PathLine { relativeX: 0; y: root.height - 32 }
      PathArc {
        relativeX: -24; relativeY: 24
        radiusX: 24; radiusY: 24
      }
      PathLine { x: root.width / 2; relativeY: 0 }
      PathLine { relativeX: 0; y: root.height }
      PathLine { x: root.width; relativeY: 0 }
      PathLine { relativeX: 0; y: 0 }
    }
  }

  // glass border
  Shape {
    id: border
    anchors.fill: parent
    visible: true
    layer.enabled: true
    layer.samples: 4
    layer.smooth: true

    ShapePath {
      fillColor: "#00000000"
      strokeColor: "#ccffffff"
      strokeWidth: 1.5

      startX: 56;
      startY: root.height / 2;
      PathLine { relativeX: 0; y: 32 }
      PathArc {
        relativeX: 24; relativeY: -24
        radiusX: 24; radiusY: 24
      }
      PathLine { x: root.width - 32; relativeY: 0 }
      PathArc {
        relativeX: 24; relativeY: 24
        radiusX: 24; radiusY: 24
      }
      PathLine { relativeX: 0; y: root.height - 32 }
      PathArc {
        relativeX: -24; relativeY: 24
        radiusX: 24; radiusY: 24
      }
      PathLine { x: root.width / 2; relativeY: 0 }
    }
  }
}
