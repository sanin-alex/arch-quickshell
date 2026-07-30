import QtQuick
import Quickshell

Rectangle {
	required property var pillWidth
	Colors { id: colors }

	color: colors.onyx
	radius: 15
	implicitWidth: pillWidth
	implicitHeight: 30
	border {
		color: colors.brightSnow
		width: 1
	}
}

