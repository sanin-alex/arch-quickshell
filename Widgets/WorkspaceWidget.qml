import QtQuick
import Quickshell.Hyprland

import "../Types"

Row {
	id: workspaceRow
    Fonts { id: fonts }

	required property var activeColor 
	required property var usedColor
	required property var unusedColor
	spacing: 8
	anchors.centerIn: parent
	Repeater {
		model: 10
		Text {
			property var workspace: Hyprland.workspaces.values.find(w => w.id === index + 1)
			property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
			height: root.implicitHeight
			verticalAlignment: Text.AlignVCenter
			text: index + 1
			color: isActive ? activeColor : (workspace ? usedColor : unusedColor)
			font.pixelSize: 15 
            font.family: fonts.name
		}
	}
}
