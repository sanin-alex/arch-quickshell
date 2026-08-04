import QtQuick
import Quickshell

import "../Types"

Rectangle {
	required property var pillWidth
	Colors { id: colors }

	color: colors.onyx
	radius: 15
	implicitWidth: pillWidth
	implicitHeight: 25
	border {
		color: colors.brightSnow
		width: 1
	}
}

