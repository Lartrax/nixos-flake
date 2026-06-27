pragma Singleton

import Quickshell

Singleton {
  id: root

  property bool open: false

  function toggleOpen(): void {
    open = !open
  }
  function setOpen(value: bool): void {
    open = value
  }
}
