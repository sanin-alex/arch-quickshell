import QtQuick
import QtQuick.Layouts

import "../Types"

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

    property bool extended: false 

    Rectangle {
        id: cover
        anchors.centerIn: parent
        implicitWidth: 20
        implicitHeight: 15
        color: colors.onyx
        z: -1
    }
    Text {
        text: battery.batteryPercentage
        color: colors.brightSnow
        anchors {
            left: root.extended ? root.right : root.left 
            verticalCenter: root.verticalCenter
        }

        Behavior on anchors.left {
            NumberAnimation {
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }
        z: -2
    }

	Rectangle {
		id: batteryIndicator
		property var fullWidth: root.implicitWidth - 5
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
	}
	Rectangle {
        anchors {
            left: root.right
			leftMargin: -1.5
            verticalCenter: root.verticalCenter
        }

        width: 2.5
        height: 4
        radius: 1
        color: colors.brightSnow
    }
}
