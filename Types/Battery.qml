import Quickshell
import QtQuick
import Quickshell.Io

Scope {
	id: root
	Colors { id: colors }

	// Battery States
	readonly property int batteryStatus_Healthy: 0
	readonly property int batteryStatus_Charging: 1
	readonly property int batteryStatus_Low: 2
	readonly property int batteryStatus_Critical: 3

	property bool batteryCharging: false
	property int batteryPercentage: -1
	property int currentBatteryStatus: batteryStatus_Healthy

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
						root.currentBatteryStatus = batteryStatus_Critical
					}
					else if (batteryPercentage <= 25) {
						root.currentBatteryStatus = batteryStatus_Low
					}
					else {
						root.currentBatteryStatus = batteryStatus_Healthy
					}
				}
				else {
					root.currentBatteryStatus = batteryStatus_Charging
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
			onStreamFinished: root.batteryCharging = (this.text.trim() === "Charging")
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

	function getColorByBatteryStatus() {
		switch(currentBatteryStatus) {
			case root.batteryStatus_Critical: return colors.red;
			case root.batteryStatus_Low: return colors.yellow;
			case root.batteryStatus_Charging: return colors.paleGreen;
			case root.batteryStatus_Healthy: return colors.brightSnow;
		}
	}
}
