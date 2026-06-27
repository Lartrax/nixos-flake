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
          left: true
          right: true
          bottom: true
        }

        implicitHeight: 8
        exclusiveZone: 8
        aboveWindows: false
        color: "#00000000"
      }
    }
  }
}
