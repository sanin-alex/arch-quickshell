import Quickshell
import QtQuick
import Quickshell.Hyprland

import "Types"
import "Widgets"

Scope {
	id: root
	Colors { id: colors }
	Battery { id: battery }
	Time { id: time }

    readonly property var mainWidgetWidth: 125
    readonly property var workspaceWidgetWidth: 185
    readonly property var extendedWidth: 400

    readonly property var isHovered: mouseArea.containsMouse

	property var activePillIndex: 0

    onIsHoveredChanged: {
        if(isHovered) {
            pillWidget.implicitWidth = extendedWidth
        } else {
            triggerMainView()
        }
    }

	Connections {
		target: Hyprland
		function onFocusedWorkspaceChanged() {
			root.triggerWorkspaceView()
		}
	}

	function triggerMainView() {
		mainWidget.opacity = 1
		workspaceWidget.opacity = 0
		pillWidget.pillWidth = mainWidgetWidth 
	}

	function triggerWorkspaceView() {
		mainWidget.opacity = 0
		workspaceWidget.opacity = 1
		pillWidget.pillWidth = workspaceWidgetWidth
		resetPillView.restart()
	}

	Timer {
		id: resetPillView
		interval: 2000
		repeat: false
		onTriggered: root.triggerMainView()
	}

	PanelWindow {
		anchors.top: true

		exclusionMode: ExclusionMode.Ignore
		implicitHeight: 35
		implicitWidth: root.extendedWidth

		color: colors.transparent

		PillWidget {
			id: pillWidget
			pillWidth: mainWidgetWidth
			anchors.centerIn: parent

			Behavior on implicitWidth {
				NumberAnimation {
					duration: 200
					easing.type: Easing.InOutQuad
				}
			}

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
            }

			MainWidget {
				id: mainWidget
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
