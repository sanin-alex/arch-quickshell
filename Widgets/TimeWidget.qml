import QtQuick
import Quickshell
Text {
	required property var systemTime
	required property var textColor
	text: systemTime 
	color: textColor
	font { pixelSize: 15 }	
}
