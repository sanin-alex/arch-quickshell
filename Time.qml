import QtQuick
import Quickshell
import Quickshell.Io

Scope {
	id: root
	// Variables
	property var systemTime: ""

	// Time Process
	Process {
		id: getTime
		command: [`date`, `+%H:%M:%S-%d/%m/%y`]
		running: true
		stdout: SplitParser {
			onRead: data => {
				var splitData = data.trim().split("-")	
				root.systemTime = splitData[0] + " | " + splitData[1]
			}
		}
	}
	Timer {
		interval: 1000
		running: true
		repeat: true
		onTriggered: getTime.running = true
	}
}
