import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

PanelWindow {
  anchors {
    top: true
    left: true
    right: true
  }
  implicitHeight: 48
  color: "#00000000"

  OpacityMask {

    source: Rectangle {
      color: "#aaffffff"
      border {
        color: "#22ffffff"
        width: 3
      }
      anchors {
        fill: parent
        rightMargin: -border.width
        topMargin: -border.width
        leftMargin: -border.width
      }
    }

    maskSource: RowLayout {
      anchors.fill: parent
      anchors.margins: 8
      anchors.bottomMargin: anchors.margins + 3

      Repeater {
        model: Hyprland.workspaces.values.length


        Text {
          property var workspaces: Hyprland.workspaces.values.filter(w => w.id != null)
          property var workspace: workspaces[index]
          property bool isActive: Hyprland.focusedWorkspace?.id === workspace.id
          property list<string> icons: ["一", "二", "三", "四", "五", "六", "七", "八", "九", "十"]

          text: icons[workspace.id - 1]
          color: isActive ? "#00000000" : (workspace ? "#7aa2f7" : "#444b6a")
          font { pixelSize: 16; bold: true }

          MouseArea {
            anchors.fill: parent
            onClicked: Hyprland.dispatch("workspace " + workspace.id)
          }
        }
      }

      Item { Layout.fillWidth: true }
    }
  }
}
