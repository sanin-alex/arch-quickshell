import QtQuick
import Quickshell

Text {
	required property string percentage
	required property var textColor
	text: percentage + "%"
	color: textColor
}
