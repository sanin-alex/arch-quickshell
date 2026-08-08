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
    Config { id: config }

    readonly property int mainWidgetWidth: config.mainWidgetWidth
    readonly property int workspaceWidgetWidth: config.workspaceWidgetWidth
    readonly property int extendedWidth: config.extendedWidth 
    readonly property int panelHeight: config.panelHeight

    readonly property bool anchorTop: config.anchorTop
    readonly property bool reserveSpace: config.reserveSpace

    readonly property bool isHovered: mouseArea.containsMouse

	Connections {
		target: Hyprland
		function onFocusedWorkspaceChanged() {
			root.triggerWorkspaceView()
		}
	}

	function triggerMainView() {
		mainWidget.opacity = 1
		workspaceWidget.opacity = 0
        if(!isHovered) {
            pillWidget.pillWidth = mainWidgetWidth 
        }
	}

	function triggerWorkspaceView() {
		mainWidget.opacity = 0
		workspaceWidget.opacity = 1
        if(!isHovered) {
            pillWidget.pillWidth = workspaceWidgetWidth
        }
		resetPillView.restart()
	}

    onIsHoveredChanged: {
        if(isHovered) {
            pillWidget.pillWidth = extendedWidth
        } else {
            triggerMainView()
        }
    }

	Timer {
		id: resetPillView
		interval: 2000
		repeat: false
		onTriggered: root.triggerMainView()
	}

	PanelWindow {
        id: panelWindow
		anchors.top: root.anchorTop ? true : false
        anchors.bottom: root.anchorTop ? false : true

		exclusionMode: root.reserveSpace ? ExclusionMode.Auto : ExclusionMode.Ignore
		implicitHeight: root.panelHeight
		implicitWidth: root.extendedWidth

		color: colors.transparent

		PillWidget {
			id: pillWidget
			pillWidth: root.mainWidgetWidth
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
                isHovered: root.isHovered
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
