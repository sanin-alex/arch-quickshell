import QtQuick
import QtQuick.Layouts

Row {
	required property var systemTime
	required property var textColor
	anchors.centerIn: parent
	Text {
		height: root.implicitHeight
		verticalAlignment: Text.AlignVCenter
		text: systemTime 
		color: textColor
		font { pixelSize: 15 }	
	}
	BatteryWidget {
	}
}
