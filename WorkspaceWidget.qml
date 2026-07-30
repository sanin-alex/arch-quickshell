import QtQuick
import Quickshell
import Quickshell.Hyprland

PillWidget{
	id: root
	required property var activeColor 
	required property var usedColor
	required property var unusedColor
	pillWidth: 185
	Row {
		id: workspaceRow
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
			}
		}
	}
}
