import Quickshell
import QtQuick
import Quickshell.Hyprland
import QtQuick.Layouts

Scope {
	Colors { id: colors }
	Battery { id: battery }
	Time { id: time }

	PanelWindow {
		anchors {
			top: true
			left: true
			right: true
		}
		implicitHeight: 20

		color: colors.onyx

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
					color: isActive ? colors.brightSnow : (workspace ? colors.slateGrey : colors.gunMetal)
					font { pixelSize: 14 }
				}
			}
			
			Item { Layout.fillWidth: true }
			
			BatteryWidget { 
				percentage: battery.batteryPercentage 
				color: battery.getColorByBatteryStatus()
			}
		}
	
		TimeWidget {
			anchor: parent
			systemTime: time.systemTime 
			textColor: colors.brightSnow
		}
		
	}
}
