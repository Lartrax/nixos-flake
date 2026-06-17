import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Shapes

PanelWindow {
  id: root
  exclusionMode: ExclusionMode.Ignore
  exclusiveZone: 0
  aboveWindows: true
  anchors { top: true; left: true; bottom: true }
  mask: Region{ item: touchArea }

  // Drawer state
  property bool open: false
  property int animMs: 120

  // Window size stays fixed, only inner drawer moves
  implicitWidth: 200
  color: "#00000000"

  Shape {
    id: drawer
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    x: 54
    height: parent.height
    width: parent.width - 54
    visible: true
    layer.enabled: true
    layer.samples: 8
    layer.smooth: true

    property real scale: root.open ? 1.0 : 0.0;

    property int paneHeight: height / 4
    property int paneWidth: (width * scale)
    property int radiusAnim: 24 * scale
    property int radiusStatic: 24

    property int yStart: (height / 2) - (paneHeight / 2)
    property int yEnd: (height / 2) + (paneHeight / 2)

    ShapePath {
      fillColor: "#88ffffff"
      strokeColor: "#ccffffff"
      strokeWidth: 1

      startX: 0;
      startY: drawer.yStart - drawer.radiusAnim;
      PathArc {
        x: drawer.radiusAnim; y: drawer.yStart
        radiusX: drawer.radiusAnim; radiusY: drawer.radiusAnim
        direction: PathArc.Counterclockwise
      }
      PathLine { x: drawer.paneWidth - drawer.radiusStatic; y: drawer.yStart }
      PathArc {
        x: drawer.paneWidth; y: drawer.yStart + drawer.radiusStatic
        radiusX: drawer.radiusStatic; radiusY: drawer.radiusStatic
      }
      PathLine { x: drawer.paneWidth; y: drawer.yEnd - drawer.radiusStatic }
      PathArc {
        x: drawer.paneWidth - drawer.radiusStatic; y: drawer.yEnd
        radiusX: drawer.radiusStatic; radiusY: drawer.radiusStatic
      }
      PathLine { x: drawer.radiusAnim; y: drawer.yEnd }
      PathArc {
        x: 0; y: drawer.yEnd + drawer.radiusAnim
        radiusX: drawer.radiusAnim; radiusY: drawer.radiusAnim
        direction: PathArc.Counterclockwise
      }
    }

    Behavior on scale {
      NumberAnimation { duration: root.animMs; easing.type: Easing.OutCubic }
    }
  }

  MouseArea {
    id: touchArea
    height: drawer.paneHeight
    width: drawer.paneWidth + 56 - 8
    y: (parent.height / 2) - (height / 2)
    x: 0
    hoverEnabled: true
    onEntered: root.open = true
    onExited: root.open = false
  }
}
