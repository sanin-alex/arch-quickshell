import QtQuick

import ".."

Rectangle {
	required property var pillWidth
    Config { id: config }

	color: config.backgroundColor
	radius: 15
	implicitWidth: pillWidth
	implicitHeight: 25
	border {
		color: config.surfaceColor
		width: config.borderWidth
	}
}

