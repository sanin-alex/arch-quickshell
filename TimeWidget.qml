import QtQuick
import QtQuick.Layouts

Text {
	required property var systemTime
	required property var textColor
	height: root.implicitHeight
	verticalAlignment: Text.AlignVCenter
	anchors.centerIn: parent
	text: systemTime 
	color: textColor
	font { pixelSize: 15 }	
}
