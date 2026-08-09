import Quickshell
import QtQuick
import Quickshell.Hyprland

import "Types"
import "Widgets"
import "."

Scope {
	id: root
	Battery { id: battery }
	Time { id: time }

    readonly property int mainWidgetWidth: Config.mainWidgetWidth
    readonly property int workspaceWidgetWidth: Config.workspaceWidgetWidth

    readonly property bool extendOnHover: Config.extendOnHover
    readonly property int extendedWidth: Config.extendedWidth 

    readonly property int panelHeight: Config.panelHeight

    readonly property bool anchorTop: Config.anchorTop
    readonly property bool reserveSpace: Config.reserveSpace

    readonly property int animationDuration: Config.animationDuration

    readonly property bool isHovered: extendOnHover ? mouseArea.containsMouse : false

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

		color: Config.transparentColor

		PillWidget {
			id: pillWidget
			pillWidth: root.mainWidgetWidth
			anchors.centerIn: parent

			Behavior on implicitWidth {
				NumberAnimation {
					duration: root.animationDuration 
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
						duration: root.animationDuration
						easing.type: Easing.InOutQuad
					}
				}
			}

			WorkspaceWidget {
				id: workspaceWidget
				activeColor: Config.surfaceColor
				usedColor: Config.usedColor
				unusedColor: Config.unusedColor
				opacity: 0
				Behavior on opacity {
					NumberAnimation {
						duration: root.animationDuration
						easing.type: Easing.InOutQuad
					}
				}
			}
		}
	}
}
