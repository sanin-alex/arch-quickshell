import QtQuick
import Quickshell
import Quickshell.Hyprland

Rectangle {
	required property var activeColor 
	required property var usedColor
	required property var unusedColor
	required property var backgroundColor
	color: backgroundColor
	radius: 15
	implicitWidth: workspaceRow.width + 20
	implicitHeight: workspaceRow.height + 10 
	Row {
		id: workspaceRow
		spacing: 8
		anchors.centerIn: parent
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
}
