import Quickshell
import QtQuick
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick.Layouts

PanelWindow {
	anchors.top: true
	anchors.left: true
	anchors.right: true
	implicitHeight: 20

	property int battery: -1
	property var systemTime

	// Time Process
	Process {
		id: getTime
		command: ["date"]
		running: true
		stdout: SplitParser {
			onRead: data => {
				var splitData = data.trim().split(/\s+/)
				systemTime = splitData[3]
			}
		}
	}
	Timer {
		interval: 1000
		running: true
		repeat: true
		onTriggered: getTime.running = true
	}

	// Battery Process
	Process {
		id: getBattery
		command: ["cat", "/sys/class/power_supply/BAT0/capacity"]
		running: true
		stdout: StdioCollector {
			onStreamFinished: battery = parseInt(this.text)
		}
	}
	Timer {
		interval: 2000
		running: true
		repeat: true
		onTriggered: getBattery.running = true
	}

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
				color: isActive? "#000000" : (workspace ? "#A0A0A0" : "#FFFFFF")
				font { pixelSize: 14 }
			}
		}
		
		Item { Layout.fillWidth: true }

		// Battery Text
		Text {
			text: battery + "%"
		}
	}

	// Time Text
	Text {
		id: time
		anchors.centerIn: parent
		text: systemTime
	}
	
}
