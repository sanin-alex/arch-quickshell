import Quickshell
import QtQuick
import Quickshell.Hyprland
import QtQuick.Layouts

Scope {
	id: root
	Colors { id: colors }
	Battery { id: battery }
	Time { id: time }

	property var activePillIndex: 0

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

	Timer {
		id: resetPillIndex
		interval: 2000
		repeat: false
		onTriggered: root.activePillIndex = 0
	}

	PanelWindow {
		anchors {
			top: true
			left: true
			right: true
		}
		exclusionMode: ExclusionMode.Ignore
		implicitHeight: 40

		color: colors.transparent

		StackLayout {
			anchors.centerIn: parent
			currentIndex: root.activePillIndex
			implicitWidth: children[currentIndex] ? children[currentIndex].implicitWidth : 0

			Behavior on implicitWidth {
				NumberAnimation {
					duration: 200
					easing.type: Easing.InOutQuad
				}
			}
			
			TimeWidget {
				id: timeWidget
				systemTime: time.systemTime
				textColor: colors.brightSnow
			}

			WorkspaceWidget {
				id: workspaceWidget
				activeColor: colors.brightSnow
				usedColor: colors.slateGrey
				unusedColor: colors.gunMetal
			}
		}
	}

}
