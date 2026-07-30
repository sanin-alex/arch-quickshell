import Quickshell
import QtQuick
import Quickshell.Hyprland
import QtQuick.Layouts

Scope {
	id: root
	Colors { id: colors }
	Battery { id: battery }
	Time { id: time }
	Margins { id: margins }

	readonly property var background: colors.onyx
	property var activePillIndex: 0

	PanelWindow {
		anchors {
			top: true
			left: true
			right: true
		}
		margins {
			top: 0
			left: 0
			right: 0
			bottom: 0
		}
		exclusionMode: ExclusionMode.Ignore
		implicitHeight: 40

		color: colors.halfTransparent

		Timer {
			id: resetPillIndex
			interval: 1000
			repeat: false
			onTriggered: root.activePillIndex = 0
		}

		StackLayout {
			anchors.centerIn: parent
			currentIndex: root.activePillIndex
			TimeWidget {
				id: timeWidget
				systemTime: time.systemTime
				textColor: colors.brightSnow
				backgroundColor: colors.onyx
			}

			WorkspaceWidget {
				id: workspaceWidget
				activeColor: colors.brightSnow
				usedColor: colors.slateGrey
				unusedColor: colors.gunMetal
				backgroundColor: colors.onyx
				Layout.alignment: Qt.AlignVCenter
			}
		}

	}
	Connections {
		target: Hyprland
		function onFocusedWorkspaceChanged() {
			root.triggerWorkspaceView()
		}
	}

	function triggerWorkspaceView() {
		root.activePillIndex = 1
		resetPillIndex.restart()
	}

		//RowLayout {
		//	anchors.fill: parent

		//	// Workspaces
		//	WorkspaceWidget {
		//		id: workspaceWidget
		//		activeColor: colors.brightSnow
		//		usedColor: colors.slateGrey
		//		unusedColor: colors.gunMetal
		//		backgroundColor: colors.onyx
		//		Layout.alignment: Qt.AlignVCenter
		//	}

		//	// Filler Item
		//	Item { Layout.fillWidth: true }

		//	// Battery
		//	BatteryWidget { 
		//		id: batteryWidget
		//		percentage: battery.batteryPercentage 
		//		backgroundColor: colors.onyx
		//		textColor: battery.getColorByBatteryStatus()
		//	}
		//}

		//// Time
		//TimeWidget {
		//	id: timeWidget
		//	anchor: parent
		//	systemTime: time.systemTime
		//	textColor: colors.brightSnow
		//	backgroundColor: colors.onyx
		//}
}
