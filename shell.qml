import Quickshell
import QtQuick
import Quickshell.Hyprland

import "Types"
import "Widgets"

Scope {
	id: root
	Battery { id: battery }
	Time { id: time }
    Config { id: config }

    readonly property int mainWidgetWidth: config.mainWidgetWidth
    readonly property int workspaceWidgetWidth: config.workspaceWidgetWidth

    readonly property bool extendOnHover: config.extendOnHover
    readonly property int extendedWidth: config.extendedWidth 

    readonly property int panelHeight: config.panelHeight
    readonly property string panelColor: config.panelColor

    readonly property bool anchorTop: config.anchorTop
    readonly property bool reserveSpace: config.reserveSpace

    readonly property int animationDuration: config.animationDuration

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

		color: root.panelColor

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
				activeColor: config.surfaceColor
				usedColor: config.usedColor
				unusedColor: config.unusedColor
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
