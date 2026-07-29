import QtQuick
import QtQuick.Layouts

Rectangle {
	required property var anchor
	required property var systemTime
	required property var textColor
	required property var backgroundColor
	anchors.centerIn: anchor
	implicitWidth: 140
	implicitHeight: 30
	radius: 15
	color: backgroundColor
	Text {
		id: textObj
		Layout.alignment: Qt.AlignVCenter
		anchors.centerIn: parent
		text: systemTime 
		color: textColor
		font { pixelSize: 14 }	
	}
}
