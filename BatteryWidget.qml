import QtQuick
import Quickshell
Rectangle {
	required property string percentage
	required property var textColor
	required property var backgroundColor
	required property var widthMargin
	required property var heightMargin
	implicitWidth: textObject.width + widthMargin
	implicitHeight: textObject.height + heightMargin
	color: backgroundColor
	radius: 15
	Text {
		id: textObject
		anchors.centerIn: parent
		text: percentage + "%"
		color: textColor
	}
}
