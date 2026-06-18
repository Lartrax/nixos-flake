import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Shapes

PanelWindow {
  id: root
  exclusionMode: ExclusionMode.Ignore
  exclusiveZone: 0
  aboveWindows: true
  anchors { left: true; right: true; bottom: true }
  mask: Region{ item: hoverRegion }

  property bool open: false
  // property bool proximityHover: false

  implicitHeight: 120
  color: "#00000000"

/*
  Shape {
    id: drawer
    anchors.left: parent.left
    anchors.right: parent.right
    y: 0
    height: parent.height - 8
    width: parent.width
    visible: true
    layer.enabled: true
    layer.samples: 8
    layer.smooth: true

    property real scale: root.open ? 1.0 : 0.0;

    property int paneHeight: height * scale
    property int paneWidth: width / 4
    property int radiusAnim: 24 * scale
    property int radiusStatic: 24

    property int xStart: (width / 2) - (paneWidth / 2)
    property int xEnd: (width / 2) + (paneWidth / 2)

    ShapePath {
      fillColor: "#aaffffff"
      strokeColor: "#ccffffff"
      strokeWidth: 1

      startX: drawer.xStart - drawer.radiusAnim;
      startY: drawer.height;
      PathArc {
        x: drawer.xStart; y: drawer.height - drawer.radiusAnim
        radiusX: drawer.radiusAnim; radiusY: drawer.radiusAnim
        direction: PathArc.Counterclockwise
      }
      PathLine { x: drawer.xStart; y: drawer.height - drawer.paneHeight + drawer.radiusStatic }
      PathArc {
        x: drawer.xStart + drawer.radiusStatic; y: drawer.height - drawer.paneHeight
        radiusX: drawer.radiusStatic; radiusY: drawer.radiusStatic
      }
      PathLine { x: drawer.xEnd - drawer.radiusStatic; y: drawer.height - drawer.paneHeight }
      PathArc {
        x: drawer.xEnd; y: drawer.height - drawer.paneHeight + drawer.radiusStatic
        radiusX: drawer.radiusStatic; radiusY: drawer.radiusStatic
      }
      PathLine { x: drawer.xEnd ; y: drawer.height - drawer.radiusAnim }
      PathArc {
        x: drawer.xEnd + drawer.radiusAnim; y: drawer.height
        radiusX: drawer.radiusAnim; radiusY: drawer.radiusAnim
        direction: PathArc.Counterclockwise
      }

    Behavior on scale {
      NumberAnimation { duration: root.animMs; easing.type: Easing.OutCubic }
    }
  }
*/

  Item {
    id: drawer
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottom: parent.bottom

    property real scale: root.open ? 1.0 : 0.0
    property color ledgeColor: root.proximityHover ? "#ccffffff" : "#00ffffff"

    height: (100 * scale) + 20 // 8 4 8
    width: parent.width / 3

    // Rectangle {
    //   id: ledge
    //   anchors.top: parent.top
    //   anchors.horizontalCenter: parent.horizontalCenter

    //   height: 4
    //   width: parent.width - 48
    //   radius: 4
    //   color: drawer.ledgeColor
    // }

    Rectangle {
      anchors.top: ledge.bottom
      anchors.topMargin: 8
      anchors.left: parent.left
      anchors.right: parent.right
      anchors.bottom: parent.bottom
      anchors.bottomMargin: 8 + (8 * drawer.scale)

      radius: 24
      color: "#88ffffff"
      border.width: 1
      border.color: "#ccffffff"
    }

    Behavior on scale {
      NumberAnimation { duration: 120; easing.type: Easing.OutCubic }
    }
    // Behavior on ledgeColor {
    //   ColorAnimation { duration: 400; easing.type: Easing.OutExpo }
    // }
  }

  Item {
    id: hoverRegion
    anchors.left: drawer.left
    anchors.right: drawer.right
    anchors.bottom: drawer.bottom

    height: drawer.height + 48

    // MouseArea {
    //   id: hoverProxy
    //   anchors.fill: parent
    //   hoverEnabled: true
    //   acceptedButtons: Qt.NoButton

    //   onEntered: root.proximityHover = true
    //   onExited: root.proximityHover = false
    // }

    // Rectangle {
    //   anchors.left: parent.left
    //   anchors.right: parent.right
    //   anchors.bottom: parent.bottom
    //   height: drawer.height
    //   color: "#22ff0000"
    // }

    MouseArea {
      id: hoverAction
      anchors.left: parent.left
      anchors.right: parent.right
      anchors.bottom: parent.bottom
      hoverEnabled: true

      height: drawer.height

      onEntered: root.open = true
      onExited: root.open = false
    }
  }
}
