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

  property var workspaceList: Hyprland.workspaces.values.filter(w => w.id != null)
  property list<string> icons: ["一", "二", "三", "四", "五", "六", "七", "八", "九", "十"]

  function wsAt(i) {
    return workspaceList[i]
  }

  function iconFor(ws) {
    return (ws && ws.id > 0 && ws.id <= icons.length) ? icons[ws.id - 1] : ""
  }

  function isActive(ws) {
    return ws && Hyprland.focusedWorkspace?.id === ws.id
  }

  Item {
    id: glassSource
    anchors.fill: parent
    visible: false
    layer.enabled: true

    Rectangle {
      anchors.fill: parent
      anchors.topMargin: -border.width
      color: "#77ffffff"
      border.color: "#99ffffff"
      border.width: 1
    }
  }

  Item {
    id: maskSource
    anchors.fill: parent
    visible: false
    layer.enabled: true

    RowLayout {
      anchors.fill: parent
      anchors.leftMargin: 12
      anchors.bottomMargin: 1

      Repeater {
        model: workspaceList.length

        Text {
          property var workspace: wsAt(index)

          leftPadding: 4
          rightPadding: 4
          text: iconFor(workspace)
          color: "#ffffffff"
          font {
            pixelSize: 20
            bold: false
          }
        }
      }

      Item { Layout.fillWidth: true }
    }
  }

  MultiEffect {
    anchors.fill: parent
    source: glassSource

    maskEnabled: true
    maskSource: maskSource
    maskInverted: true

    maskThresholdMin: 0.5
    maskThresholdMax: 1.0
    maskSpreadAtMin: 1.0
    maskSpreadAtMax: 1.0
  }

  RowLayout {
    anchors.fill: parent
    anchors.leftMargin: 12
    anchors.bottomMargin: 1

    Repeater {
      model: workspaceList.length

      Text {
        property var workspace: wsAt(index)

        leftPadding: 4
        rightPadding: 4

        text: iconFor(workspace)
        color: isActive(workspace) ? "#22000000" : "#22ffffff"
        font {
          pixelSize: 20
          bold: false
        }

        MouseArea {
          anchors.fill: parent
          onClicked: if (workspace) Hyprland.dispatch("workspace " + workspace.id)
        }
      }
    }

    Item { Layout.fillWidth: true }
  }
}
