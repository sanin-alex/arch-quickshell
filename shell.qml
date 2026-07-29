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
			WorkspaceWidget {
				activeColor: colors.brightSnow
				usedColor: colors.slateGrey
				unusedColor: colors.gunMetal
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
