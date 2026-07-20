import Quickshell
import QtQuick
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick.Layouts

PanelWindow {
	anchors.top: true
	anchors.left: true
	anchors.right: true
	implicitHeight: 30

	// Time
	Process {
		id: getTime
		command: ["date"]
		running: true
		stdout: SplitParser {
			onRead: data => {
				var splitData = data.trim().split(/\s+/)
				time.text = data
				time.text = splitData[3]
			}
		}
	}
	Timer {
		interval: 1000
		running: true
		repeat: true
		onTriggered: getTime.running = true
	}

	RowLayout {
		anchors.fill: parent
		anchors.margins: 8

		Repeater {
			model: 9

			Text {
				property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
				property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
				text: index + 1
				color: isActive? "#000000" : (ws ? "#A0A0A0" : "#FFFFFF")
				font { pixelSize: 14 }
			}
		}
		Item { Layout.fillWidth: true }
	}
	Text {
		id: time
		anchors.centerIn: parent
	}
}
