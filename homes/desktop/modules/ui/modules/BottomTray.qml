import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Shapes

PanelWindow {
  id: root
  // exclusionMode: ExclusionMode.Ignore
  exclusiveZone: 0
  aboveWindows: true
  anchors { top: true; left: true; bottom: true }

  // Drawer state
  property bool open: false
  property int drawerWidth: 300
  property int peekWidth: 8
  property int animMs: 100

  // Window size stays fixed; only inner drawer moves
  implicitWidth: drawerWidth + peekWidth
  color: "#00000000"

  Shape {
    id: glassDrawer
    anchors.fill: parent
    visible: true
    layer.enabled: true
    layer.samples: 8
    layer.smooth: true

    ShapePath {
      fillColor: "#ff000000"

      property int ph: glassDrawer.height
      property int pw: glassDrawer.width
      property int yStart: (ph / 2) - (ph / 5)

      startX: 0;
      startY: yStart;
      PathArc {
        x: 24; y: yStart
        radiusX: 24; radiusY: 24
      }
      PathLine { x: pw - 24; y: yStart }
    }
  }

  Rectangle {
    id: drawer
    z: 2
    anchors.verticalCenter: parent.verticalCenter
    width: root.drawerWidth
    height: parent.height / 5
    radius: 24
    color: "#88ffffff"

    // Closed => leave a small visible strip
    x: root.open ? root.peekWidth : -(width - root.peekWidth)

    Behavior on x {
      NumberAnimation { duration: root.animMs; easing.type: Easing.OutCubic }
    }

    focus: root.open

    Column {
      anchors.fill: parent
      anchors.margins: 12
      // spacing: 12

      Label { text: "Drawer" }
    }

    MouseArea {
      anchors.fill: parent
      hoverEnabled: true
      onExited: root.open = false
    }
  }

  // Edge handle: always visible, always clickable
  Rectangle {
    id: handle
    z: 3
    x: -56
    anchors.top: drawer.top
    anchors.bottom: drawer.bottom
    width: root.peekWidth + 56
    visible: true
    color: "#00000000"

    MouseArea {
      anchors.fill: parent
      hoverEnabled: true
      onEntered: root.open = true
    }
  }
}
