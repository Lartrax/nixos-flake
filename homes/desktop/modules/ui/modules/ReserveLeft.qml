import Quickshell
import QtQuick

Scope {
  id: root

  Variants {
    model: Quickshell.screens

    delegate: Component {
      PanelWindow {
        required property var modelData
        screen: modelData

        anchors {
          top: true
          left: true
          bottom: true
        }

        implicitWidth: 56
        exclusiveZone: 56
        aboveWindows: false
        color: "#00000000"
      }
    }
  }
}
