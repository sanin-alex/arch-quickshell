import QtQuick
import Quickshell
import Quickshell.Hyprland

Row {
	required property var activeColor 
	required property var usedColor
	required property var unusedColor
	spacing: 6
	Repeater {
		model: 10
		Text {
			property var workspace: Hyprland.workspaces.values.find(w => w.id === index + 1)
			property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
			text: index + 1
			color: isActive ? activeColor : (workspace ? usedColor : unusedColor)
			font { pixelSize: 14 }
		}
	}
}
