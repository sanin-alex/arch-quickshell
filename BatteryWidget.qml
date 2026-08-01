import QtQuick
import QtQuick.Layouts

Rectangle {
	Battery { id: battery }
	Colors { id: colors }

	id: root
	implicitWidth: 18
	implicitHeight: 8
	radius: 15
	border.width: 1
	border.color: colors.brightSnow
	color: colors.onyx

	Rectangle {
		id: batteryIndicator
		property var fullWidth: root.implicitWidth - 4
		property var currentWidth: fullWidth * (battery.batteryPercentage / 100)
		implicitWidth: currentWidth
		radius: 15
		anchors {
			left: parent.left
			top: parent.top
			bottom: parent.bottom
			margins: 2.5
		}
		color: battery.getColorByBatteryStatus()
		Component.onCompleted: { console.log(battery.getColorByBatteryStatus()) }
	}
}
