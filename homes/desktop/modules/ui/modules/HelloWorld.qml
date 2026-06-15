import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Effects

PanelWindow {
  anchors {
    top: true
    left: true
    right: true
  }
  implicitHeight: 48
  color: "#00000000"

  Rectangle {
    id: glassBase
    anchors.fill: parent
    anchors.topMargin: -border.width
    color: "#55ffffff"
    border.color: "#88ffffff"
    border.width: 1
  }

  MultiEffect {
    anchors.fill: parent
    source: glassBase
    blurEnabled: true
    blur: 48
  }

  RowLayout {
    anchors.fill: parent
    anchors.leftMargin: 12
    anchors.bottomMargin: 1 // account for border

    Repeater {
      model: Hyprland.workspaces.values.length

      Text {
        property var workspaces: Hyprland.workspaces.values.filter(w => w.id != null)
        property var workspace: workspaces[index]
        property bool isActive: Hyprland.focusedWorkspace?.id === workspace.id
        property list<string> icons: ["一", "二", "三", "四", "五", "六", "七", "八", "九", "十"]

        leftPadding: 4
        rightPadding: 4

        text: icons[workspace.id - 1]
        color: isActive ? "#aa000000" : (workspace ? "#88eeeeee" : "#ff0000")
        font { pixelSize: 18; bold: false }

        MouseArea {
          anchors.fill: parent
          onClicked: Hyprland.dispatch("workspace " + workspace.id)
        }
      }
    }
    Item { Layout.fillWidth: true }
  }
}
