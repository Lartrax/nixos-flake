import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick

import "./frameParts" as Frame

Scope {
  id: root

  Variants {
    model: Quickshell.screens

    delegate: Component {
      PanelWindow {
        required property var modelData
        screen: modelData

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

        Frame.Workspace {}

        Frame.StaticSection {}
      }
    }
  }
}

