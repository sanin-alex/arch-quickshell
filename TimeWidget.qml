import QtQuick
import QtQuick.Layouts

PillWidget {
	id: root
	required property var systemTime
	required property var textColor
	pillWidth: 100
	Text {
		id: textObj
		height: root.implicitHeight
		verticalAlignment: Text.AlignVCenter
		anchors.centerIn: parent
		text: systemTime 
		color: textColor
		font { pixelSize: 15 }	
	}
}
