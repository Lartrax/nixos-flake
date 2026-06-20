import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Shapes

PanelWindow {
  id: root
  exclusionMode: ExclusionMode.Ignore
  aboveWindows: true
  anchors {
    top: true
    left: true
    right: true
    bottom: true
  }
  mask: Region{}

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

  // workspace cutout
  Item {
    id: workspaceMask
    anchors.fill: parent
    visible: false
    layer.enabled: true

    ColumnLayout {
      anchors.fill: parent
      anchors.topMargin: 12
      anchors.leftMargin: 16

      Repeater {
        model: workspaceList.length

        Text {
          property var workspace: wsAt(index)

          topPadding: 4
          bottomPadding: 4
          text: iconFor(workspace)
          color: "#ffffffff"
          font {
            pixelSize: 20
            bold: false
          }
        }
      }

      Item { Layout.fillHeight: true }
    }
  }

  // top left glass frame
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
      PathLine { relativeX: 0; relativeY: 8 }
      PathLine { relativeX: 0; y: root.height / 2 }
      PathLine { x: 0; relativeY: 0 }
      PathLine { x: 0; y: 0 }
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
      startY: 32;
      PathLine { relativeX: 0; y: root.height / 2 }
    }
  }

  // workspace highlight color
  ColumnLayout {
    anchors.fill: parent
    anchors.topMargin: 12
    anchors.leftMargin: 16

    Repeater {
      model: workspaceList.length

      Text {
        property var workspace: wsAt(index)

        topPadding: 4
        bottomPadding: 4

        text: iconFor(workspace)
        color: isActive(workspace) ? "#33000000" : "#22ffffff"
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

    Item { Layout.fillHeight: true }
  }

  // workspace mask applied to glass frame
  MultiEffect {
    id: workspaceCutout
    anchors.fill: parent
    source: glass

    maskEnabled: true
    maskSource: workspaceMask
    maskInverted: true

    maskThresholdMin: 0.5
    maskThresholdMax: 1.0
    maskSpreadAtMin: 1.0
    maskSpreadAtMax: 0.0
  }
}
