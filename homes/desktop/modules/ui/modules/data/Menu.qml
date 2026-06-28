pragma Singleton

import Quickshell

Singleton {
  id: root

  property var openStates: ({})
  property int stateRevision: 0

  function isOpen(screenId: string): bool {
    // use stateRevision as callback bind
    var _revision = stateRevision
    return openStates[screenId]
  }

  function toggleOpen(screenId: string): void {
    openStates[screenId] = !openStates[screenId]
    stateRevision++
  }
  
  function setOpen(screenId: string, value: bool): void {
    openStates[screenId] = value
    stateRevision++
  }
}
