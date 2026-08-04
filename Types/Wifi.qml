import QtQuick
import Quickshell

Scope {
    id: root
    property var currentNetwork = "Not Connected"
	Process {
		id: getCurrentNetwork
		command: [`iwctl`, `station`, `wlan0`, `show`]
		running: true
		stdout: SplitParser {
			onRead: data => {
                console.log(data)
			}
		}
	}
	Timer {
		interval: 1000
		running: true
		repeat: true
		onTriggered: getCurrentNetwork.running = true
	}
}
