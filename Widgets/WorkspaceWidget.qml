import QtQuick
import Quickshell.Hyprland

import "../Types"

Row {
	id: root 
    Fonts { id: fonts }

	required property string activeColor 
	required property string usedColor
	required property string unusedColor
	spacing: 8
	anchors.centerIn: parent
	Repeater {
		model: 10
		Text {
			property var workspace: Hyprland.workspaces.values.find(w => w.id === index + 1)
			property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
			verticalAlignment: Text.AlignVCenter
			text: index + 1
			color: isActive ? root.activeColor : (workspace ? root.usedColor : root.unusedColor)
			font.pixelSize: 15 
            font.family: fonts.name
		}
	}
}
