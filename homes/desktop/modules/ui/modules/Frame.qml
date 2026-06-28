import Quickshell
import QtQuick

import "./frameParts" as Frame
import "./data"

Scope {
  id: root

  Variants {
    model: Quickshell.screens

    delegate: Component {
      PanelWindow {
        id: window
        required property var modelData
        screen: modelData
        property string screenId: modelData?.name ?? "default"

        exclusionMode: ExclusionMode.Ignore
        aboveWindows: true
        anchors {
          top: true
          left: true
          right: true
          bottom: true
        }
        mask: Region {
          item: menuRegion
        }

        color: "#00000000"

        // visual frame
        Frame.Workspace {}
        Frame.Menu { screenId: window.screenId }
        Frame.StaticSection {}

        // frame click regions
        Rectangle {
          id: menuRegion
          anchors.left: parent.left
          anchors.bottom: parent.bottom
          visible: false

          property bool open: Menu.isOpen(window.screenId)
          property real scale: open ? 1.0 : 0.0

          implicitHeight: (parent.height / 2) - 24
          implicitWidth: 56 + (Math.max((parent.width / 6) - 32, 0) * scale)

          Behavior on scale {
            NumberAnimation { duration: 120; easing.type: Easing.OutCubic }
          }
        }
      }
    }
  }
}

