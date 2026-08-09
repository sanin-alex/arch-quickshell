import Quickshell
import QtQuick
import Quickshell.Io

import ".."

Scope {
	id: root
    Config { id: config }

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
				root.batteryPercentage = parseInt(this.text)
				if(!root.batteryCharging) {
					if(root.batteryPercentage <= 15) {
						root.currentBatteryStatus = root.batteryStatus_Critical
					}
					else if (root.batteryPercentage <= 25) {
						root.currentBatteryStatus = root.batteryStatus_Low
					}
					else {
						root.currentBatteryStatus = root.batteryStatus_Healthy
					}
				}
				else {
					root.currentBatteryStatus = root.batteryStatus_Charging
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
			case root.batteryStatus_Critical: return config.batteryCriticalColor;
			case root.batteryStatus_Low: return config.batteryWarningColor;
			case root.batteryStatus_Charging: return config.batteryChargingColor;
			case root.batteryStatus_Healthy: return config.surfaceColor;
		}
	}
}
