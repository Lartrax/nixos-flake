pragma Singleton

import Quickshell
import QtQuick

Singleton {
  id: root

  readonly property string hour: {
    Qt.formatDateTime(clock.date, "hh")
  }
  readonly property string minute: {
    Qt.formatDateTime(clock.date, "mm")
  }

  SystemClock {
    id: clock
    precision: SystemClock.Minutes
  }
}
