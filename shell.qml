import Quickshell
import QtQuick
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick.Layouts

PanelWindow {
	property var carbonBlack: "#212529"
	property var gunMetal: "#343A40"
	property var ironGrey: "#495057"
	property var slateGrey: "#6C757D"
	property var brightSnow: "#F8F9FA"

	property var paleGreen: "#98fb98"

	property int battery: -1
	property bool charging: false
	property var systemTime

	// Time Process
	Process {
		id: getTime
		command: [`date`, `+%H:%M:%S-%d/%m/%y`]
		running: true
		stdout: SplitParser {
			onRead: data => {
				var splitData = data.trim().split("-")	
				systemTime = splitData[0] + " | " + splitData[1]
			}
		}
	}
	Timer {
		interval: 1000
		running: true
		repeat: true
		onTriggered: getTime.running = true
	}

	// Battery 

	// Capacity
	Process {
		id: getBatteryCapacity
		command: ["cat", "/sys/class/power_supply/BAT0/capacity"]
		running: true
		stdout: StdioCollector {
			onStreamFinished: battery = parseInt(this.text)
		}
	}
	// Status
	Process {
		id: getBatteryStatus
		command: ["cat", "/sys/class/power_supply/BAT0/status"]
		running: true
		stdout: StdioCollector {
			onStreamFinished: charging = (this.text.trim() === "Charging")
		}
	}
	Timer {
		interval: 2000
		running: true
		repeat: true
		onTriggered: {
			getBatteryCapacity.running = true
			getBatteryStatus.running = true
		}
	}

	anchors {
		top: true
		left: true
		right: true
	}
	implicitHeight: 20

	color: carbonBlack

	RowLayout {
		anchors.fill: parent
		anchors.margins: 2 

		// Workspaces
		Repeater {
			model: 9
			Text {
				property var workspace: Hyprland.workspaces.values.find(w => w.id === index + 1)
				property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
				text: index + 1
				color: isActive ? brightSnow : (workspace ? slateGrey : ironGrey)
				font { pixelSize: 14 }
			}
		}
		
		Item { Layout.fillWidth: true }

		// Battery Text
		Text {
			text: battery + "%"
			color: charging ? paleGreen : brightSnow
		}
	}

	// Time & Date Text
	Text {
		id: time
		anchors.centerIn: parent
		text: systemTime 
		color: brightSnow
	}
	
}
