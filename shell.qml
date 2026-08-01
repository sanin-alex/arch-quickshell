import Quickshell
import QtQuick
import Quickshell.Hyprland

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

	function triggerTimeView() {
		timeWidget.opacity = 1
		workspaceWidget.opacity = 0
		pillWidget.pillWidth = 100
		resetPillView.restart()
	}

	function triggerWorkspaceView() {
		timeWidget.opacity = 0
		workspaceWidget.opacity = 1
		pillWidget.pillWidth = 185
		resetPillView.restart()
	}

	Timer {
		id: resetPillView
		interval: 2000
		repeat: false
		onTriggered: root.triggerTimeView()
	}

	PanelWindow {
		anchors.top: true

		exclusionMode: ExclusionMode.Ignore
		implicitHeight: 35
		implicitWidth: 200

		color: colors.transparent

		PillWidget {
			id: pillWidget
			pillWidth: 100
			anchors.centerIn: parent

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
				Behavior on opacity {
					NumberAnimation {
						duration: 200
						easing.type: Easing.InOutQuad
					}
				}
			}

			WorkspaceWidget {
				id: workspaceWidget
				activeColor: colors.brightSnow
				usedColor: colors.slateGrey
				unusedColor: colors.gunMetal
				opacity: 0
				Behavior on opacity {
					NumberAnimation {
						duration: 200
						easing.type: Easing.InOutQuad
					}
				}
			}
		}
	}
}
