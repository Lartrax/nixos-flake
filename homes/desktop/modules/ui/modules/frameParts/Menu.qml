import Quickshell
import Quickshell.Networking
import QtQuick
import QtQuick.Shapes
import QtQuick.Effects

import "../widgets"
import "../data"

Item {
  id: root
  anchors {
    left: parent.left
    bottom: parent.bottom
  }

  implicitHeight: parent.height / 2
  implicitWidth: parent.width / 2

  property bool menuOpen: false
  property real scale: menuOpen ? 1.0 : 0.0

  Behavior on scale {
    NumberAnimation { duration: 120; easing.type: Easing.OutCubic }
  }

  // bottom left glass frame
  Shape {
    id: glass
    anchors.fill: parent

    ShapePath {
      id: path
      fillColor: "#aaffffff"
      strokeColor: "#00000000"

      property real widthAnim: ((root.width / 3) - 24 - 56) * root.scale
      property real radiusAnim: { Math.min(widthAnim / 2, 24) }

      startX: 56;
      startY: 0;
      PathArc {
        relativeX: path.radiusAnim; relativeY: path.radiusAnim
        radiusX: path.radiusAnim; radiusY: path.radiusAnim
        direction: PathArc.Counterclockwise
      }
      PathLine { relativeX: path.widthAnim; relativeY: 0 }
      PathArc {
        relativeX: path.radiusAnim; relativeY: path.radiusAnim
        radiusX: path.radiusAnim; radiusY: path.radiusAnim
      }
      PathLine { relativeX: 0; y: root.height - 32 }
      PathArc {
        relativeX: 24; relativeY: 24
        radiusX: 24; radiusY: 24
        direction: PathArc.Counterclockwise
      }
      PathLine { x: root.width; relativeY: 0 }
      PathLine { relativeX: 0; y: root.height }
      PathLine { x: 0; relativeY: 0 }
      PathLine { relativeX: 0; y: 0 }
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
      startY: 0;
      PathArc {
        relativeX: path.radiusAnim; relativeY: path.radiusAnim
        radiusX: path.radiusAnim; radiusY: path.radiusAnim
        direction: PathArc.Counterclockwise
      }
      PathLine { relativeX: path.widthAnim; relativeY: 0 }
      PathArc {
        relativeX: path.radiusAnim; relativeY: path.radiusAnim
        radiusX: path.radiusAnim; radiusY: path.radiusAnim
      }
      PathLine { relativeX: 0; y: root.height - 32 }
      PathArc {
        relativeX: 24; relativeY: 24
        radiusX: 24; radiusY: 24
        direction: PathArc.Counterclockwise
      }
      PathLine { x: root.width; relativeY: 0 }
    }
  }

  Item {
    id: clockMask
    anchors.fill: parent

    Item {
      anchors.left: parent.left
      anchors.bottom: parent.bottom
      anchors.bottomMargin: 32
      implicitWidth: 56

      ClockWidget {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom

        color: "#55000000"
        font.pixelSize: 20
      }
    }
  }

  Item {
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.bottom: parent.bottom

    implicitHeight: pill.height
    implicitWidth: 56

    Rectangle {
      id: pillMask
      anchors.fill: pill
      visible: false
      layer.enabled: true

      color: "#ffffffff"
      radius: 24
    }

    MultiEffect {
      anchors.fill: pillMask
      source: pillMask

      shadowEnabled: true
      shadowColor: "#55000000"
      shadowBlur: 0.2

      maskEnabled: true
      maskSource: pillMask
      maskInverted: false

      maskThresholdMin: 0.0
      maskThresholdMax: 0.2
      maskSpreadAtMin: 1.0
      maskSpreadAtMax: 0.0
    }

    Rectangle {
      id: pill
      anchors.centerIn: parent
      implicitHeight: items.height + 16
      implicitWidth: parent.width - 16

      color: "#55ffffff"
      border.color: "#aaffffff"
      border.width: 1.0
      radius: 24

      Column {
        id: items
        anchors.centerIn: parent
        spacing: 8

        Text {
          id: audioIn
          anchors.horizontalCenter: parent.horizontalCenter

          property var mic: Pipewire.source
          property bool micExists: mic != null
          property bool muted: Pipewire.sourceMuted

          color: muted ? "#99b74d6f" : "#55000000"
          text: {
            if (micExists)
              return muted ? "󰍭" : "󰍬"

            return "󰍮"
          }
          font.pixelSize: 20
        }

        Row {
          id: audioOut
          anchors.horizontalCenter: parent.horizontalCenter
          spacing: 4

          property var speaker: Pipewire.sink
          property bool speakerExists: speaker != null
          property bool muted: Pipewire.sinkMuted
          property real volume: Pipewire.sinkVolume

          Text {
            id: speakerText
            color: "#55000000"
            text: ""
            font.pixelSize: 20
          }

          Item {
            id: speakerVolume
            anchors.top: speakerText.top
            anchors.bottom: speakerText.bottom

            implicitWidth: volumeBorder.width

            Rectangle {
              id: volumeBorder
              anchors.top: parent.top
              anchors.bottom: parent.bottom

              implicitWidth: 4
              radius: 4

              color: "#00000000"
              border.color: audioOut.muted ? "#99b74d6f" : "#55000000"

              Rectangle {
                id: volumeBar
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.margins: 1.25

                implicitHeight: (volumeBorder.height - 2.5) * audioOut.volume
                radius: 4

                color: audioOut.muted ? "#99b74d6f" : "#55000000"
              }
            }
          }
        }

        Repeater {
          id: network
          model: Networking.devices.values.length

          property var wifi: ({
            icons: ["󰤯", "󰤟", "󰤢", "󰤥","󰤨"],
            openConnectionIcons: ["󱛏", "󱛋", "󱛌", "󱛍", "󱛎"],
            noInternetIcons: ["󰤫", "󰤠", "󰤣", "󰤦", "󰤩"]
          })

          Text {
            id: networkIcon
            anchors.horizontalCenter: parent.horizontalCenter

            property var device: Networking.devices.values[index]
            property string statusIcon: {
              if (device.type === DeviceType.Wifi) {
                if (device.state === ConnectionState.Disconnected)
                  return "󰤭"
                if (device.state === ConnectionState.Connecting)
                  return ""

                var net = device.networks.values[0]
                var getIcons = () => {
                  if (Networking.connectivity != NetworkConnectivity.Full)
                    return network.wifi.noInternetIcons
                  if (net?.security == WifiSecurityType.Open)
                    return network.wifi.openConnectionIcons

                  return network.wifi.icons
                }

                if (net?.signalStrength <= 0.1)
                  return getIcons()[0]
                if (net?.signalStrength <= 0.25)
                  return getIcons()[1]
                if (net?.signalStrength <= 0.5)
                  return getIcons()[2]
                if (net?.signalStrength <= 0.75)
                  return getIcons()[3]
                if (net?.signalStrength <= 1.0)
                  return getIcons()[4]

                return "󰤮"
              }

              if (device.type === DeviceType.Wired) {
                if (device.state === ConnectionState.Connected) {
                  // portal or no internet
                  if (Networking.connectivity != NetworkConnectivity.Full)
                    return "󰈁!"

                  // connected with internet
                  return "󰈁"
                }
                if (device.state === ConnectionState.Connecting)
                  return ""

                return "󰈂"
              }

              // type = DeviceType.None
              return "󰲊"
            }

            color: "#55000000"
            text: statusIcon
            font.pixelSize: 20

            RotationAnimation on rotation {
              loops: Animation.Infinite
              from: 0
              to: 360
              running: device.state === ConnectionState.Connecting
              alwaysRunToEnd: true
              duration: 800
            }
          }
        }
      }

      MouseArea {
        id: pillPressArea
        anchors.fill: parent

        onClicked: {
          root.menuOpen = !root.menuOpen
        }
      }
    }
  }
}
