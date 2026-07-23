import Quickshell
import QtQuick
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick.Layouts

PanelWindow {
	// Battery States
	readonly property int batteryStatus_Healthy: 0
	readonly property int batteryStatus_Charging: 1
	readonly property int batteryStatus_Low: 2
	readonly property int batteryStatus_Critical: 3

	// Colors
	readonly property var onyx: "#0F0F0F"
	readonly property var gunMetal: "#343A40"
	readonly property var ironGrey: "#495057"
	readonly property var slateGrey: "#6C757D"
	readonly property var brightSnow: "#F8F9FA"
	readonly property var paleGreen: "#98fb98"
	readonly property var yellow: "#FFFF00"
	readonly property var red: "#FF0000"

	// Variables
	property bool batteryCharging: false
	property int batteryPercentage: -1
	property int currentBatteryStatus: batteryStatus_Healthy
	property var systemTime: ""

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

	// Percentage
	Process {
		id: getBatteryPercentage
		command: ["cat", "/sys/class/power_supply/BAT0/capacity"]
		running: true
		stdout: StdioCollector {
			onStreamFinished: { 
				batteryPercentage = parseInt(this.text)
				if(!batteryCharging) {
					if(batteryPercentage <= 15) {
						currentBatteryStatus = batteryStatus_Critical
					}
					else if (batteryPercentage <= 25) {
						currentBatteryStatus = batteryStatus_Low
					}
					else {
						currentBatteryStatus = batteryStatus_Healthy
					}
				}
				else {
					currentBatteryStatus = batteryStatus_Charging
				}
			}
		}
	}
	// Status
	Process {
		id: getBatteryStatus
		command: ["cat", "/sys/class/power_supply/BAT0/status"]
		running: true
		stdout: StdioCollector {
			onStreamFinished: batteryCharging = (this.text.trim() === "Charging")
		}
	}
	Timer {
		interval: 2000
		running: true
		repeat: true
		onTriggered: {
			getBatteryPercentage.running = true
			getBatteryStatus.running = true
		}
	}

	anchors {
		top: true
		left: true
		right: true
	}
	implicitHeight: 20

	color: onyx

	RowLayout {
		anchors.fill: parent
		anchors.margins: 2 

		// Workspaces
		Repeater {
			model: 10
			Text {
				property var workspace: Hyprland.workspaces.values.find(w => w.id === index + 1)
				property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
				text: index + 1
				color: isActive ? brightSnow : (workspace ? slateGrey : gunMetal)
				font { pixelSize: 14 }
			}
		}
		
		Item { Layout.fillWidth: true }

		// Battery Text
		Text {
			text: batteryPercentage + "%"
			function getColorByBatteryStatus() {
				switch(currentBatteryStatus) {
					case batteryStatus_Critical: return red;
					case batteryStatus_Low: return yellow;
					case batteryStatus_Charging: return paleGreen;
					case batteryStatus_Healthy: return brightSnow;
				}
			}
			color: getColorByBatteryStatus()
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
