import QtQuick

Text {
	required property var anchor
	required property var systemTime
	required property var textColor

	anchors.centerIn: anchor
	text: systemTime 
	color: textColor
}
