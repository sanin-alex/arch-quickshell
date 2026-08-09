import QtQuick

import ".."

Rectangle {
	required property var pillWidth

	color: Config.backgroundColor
	radius: 15
	implicitWidth: pillWidth
	implicitHeight: 25
	border {
		color: Config.surfaceColor
		width: Config.borderWidth
	}
}

