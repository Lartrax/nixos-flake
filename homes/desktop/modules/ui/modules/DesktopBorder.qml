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
    id: maskText
    anchors.fill: parent
    visible: false
    layer.enabled: true
    layer.samples: 8
    layer.smooth: true

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

  // screen cutout
  Shape {
    id: maskCutout
    anchors.fill: parent
    visible: false
    layer.enabled: true
    layer.samples: 8
    layer.smooth: true

    ShapePath {
      fillColor: "#ff000000"

      startX: 54;
      startY: 8 + 24;
      PathLine { x: 54; y: root.height - 8 - 24 }
      PathArc {
        x: 54 + 24; y: root.height - 8
        radiusX: 24; radiusY: 24
        direction: PathArc.Counterclockwise
      }
      PathLine { x: root.width - 8 - 24; y: root.height - 8 }
      PathArc {
        x: root.width - 8; y: root.height - 8 - 24
        radiusX: 24; radiusY: 24
        direction: PathArc.Counterclockwise
      }
      PathLine { x: root.width - 8; y: 8 + 24 }
      PathArc {
        x: root.width - 8 - 24; y: 8
        radiusX: 24; radiusY: 24
        direction: PathArc.Counterclockwise
      }
      PathLine { x: 54 + 24; y: 8 }
      PathArc {
        x: 54; y: 8 + 24
        radiusX: 24; radiusY: 24
        direction: PathArc.Counterclockwise
      }
    }
  }

  // glass base
  Item {
    id: glassSource
    anchors.fill: parent
    visible: false
    layer.enabled: true
    layer.samples: 8
    layer.smooth: true

    Rectangle {
      anchors.fill: parent
      color: "#aaffffff"
    }
  }

  // cutout screen
  MultiEffect {
    id: glassCutout
    anchors.fill: parent
    source: glassSource
    visible: false
    layer.enabled: true
    layer.samples: 8
    layer.smooth: true

    maskEnabled: true
    maskSource: maskCutout
    maskInverted: true

    maskThresholdMin: 0.9
    maskThresholdMax: 1.0
    maskSpreadAtMin: 0.0
    maskSpreadAtMax: 1.0
  }

  // cutout workspace
  MultiEffect {
    id: workspaceCutout
    anchors.fill: parent
    source: glassCutout
    visible: true
    layer.samples: 8
    layer.smooth: true

    maskEnabled: true
    maskSource: maskText
    maskInverted: true

    maskThresholdMin: 0.5
    maskThresholdMax: 1.0
    maskSpreadAtMin: 1.0
    maskSpreadAtMax: 1.0
  }

  // workspace active color
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

  // border
  Shape {
    anchors.fill: parent
    layer.enabled: true
    layer.samples: 8
    layer.smooth: true

    ShapePath {
      strokeColor: "#ccffffff"
      strokeWidth: 1.5
      fillColor: "#00000000"

      startX: 54;
      startY: 8 + 24;
      PathLine { x: 54; y: root.height - 8 - 24 }
      PathArc {
        x: 54 + 24; y: root.height - 8
        radiusX: 24; radiusY: 24
        direction: PathArc.Counterclockwise
      }
      PathLine { x: root.width - 8 - 24; y: root.height - 8 }
      PathArc {
        x: root.width - 8; y: root.height - 8 - 24
        radiusX: 24; radiusY: 24
        direction: PathArc.Counterclockwise
      }
      PathLine { x: root.width - 8; y: 8 + 24 }
      PathArc {
        x: root.width - 8 - 24; y: 8
        radiusX: 24; radiusY: 24
        direction: PathArc.Counterclockwise
      }
      PathLine { x: 54 + 24; y: 8 }
      PathArc {
        x: 54; y: 8 + 24
        radiusX: 24; radiusY: 24
        direction: PathArc.Counterclockwise
      }
    }
  }
}
