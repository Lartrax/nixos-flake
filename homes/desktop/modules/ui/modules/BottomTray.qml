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
  mask: Region{ item: hoverAction }

  property bool open: false

  implicitHeight: 120
  color: "#00000000"

  Item {
    id: drawer
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottom: parent.bottom

    property real scale: root.open ? 1.0 : 0.0

    height: (parent.height * scale)
    width: parent.width / 3

    Rectangle {
      anchors.fill: parent
      anchors.bottomMargin: (28 * drawer.scale)

      radius: 24
      color: "#88ffffff"
      border.width: 1
      border.color: "#ccffffff"
    }

    Behavior on scale {
      NumberAnimation { duration: 80; easing.type: Easing.OutCubic }
    }
  }

  MouseArea {
    id: hoverAction
    anchors.left: drawer.left
    anchors.right: drawer.right
    anchors.bottom: drawer.bottom
    height: drawer.height + 16

    hoverEnabled: true

    onEntered: root.open = true
    onExited: root.open = false
  }
}
