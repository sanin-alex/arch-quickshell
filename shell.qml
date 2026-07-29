import Quickshell
import QtQuick
import Quickshell.Hyprland
import QtQuick.Layouts

Scope {
	Colors { id: colors }
	Battery { id: battery }
	Time { id: time }

	readonly property var background: colors.onyx

	PanelWindow {
		anchors {
			top: true
			left: true
			right: true
		}
		exclusionMode: ExclusionMode.Ignore
		implicitHeight: 40

		color: colors.transparent

		RowLayout {
			anchors.fill: parent
			anchors.margins: 2 

			// Workspaces
			WorkspaceWidget {
				activeColor: colors.brightSnow
				usedColor: colors.slateGrey
				unusedColor: colors.gunMetal
				backgroundColor: colors.onyx
			}

			Item { Layout.fillWidth: true }

			Rectangle {
				implicitWidth: batteryWidget.width + 20
				implicitHeight: batteryWidget.height + 10
				color: background
				radius: 15
				BatteryWidget { 
					id: batteryWidget
					anchors.centerIn: parent
					percentage: battery.batteryPercentage 
					color: battery.getColorByBatteryStatus()
				}
			}
		}

		Rectangle {
			implicitWidth: timeWidget.width + 20
			implicitHeight: timeWidget.height + 10
			radius: 15
			anchors.centerIn: parent
			color: background
			TimeWidget {
				id: timeWidget
				anchor: parent
				systemTime: time.systemTime 
				textColor: colors.brightSnow
			}
		}
		
	}
}
