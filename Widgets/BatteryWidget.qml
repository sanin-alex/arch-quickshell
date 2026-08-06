import QtQuick

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
    property int coverWidth: 20

    onExtendedChanged: {
        if(extended) {
            percentageText.anchors.leftMargin = coverWidth
        } else {
            percentageText.anchors.leftMargin = 0 
        }
        console.log(extended)
    }

    Rectangle {
        id: cover
        anchors.centerIn: parent
        implicitWidth: 20
        implicitHeight: 15
        color: colors.onyx
        z: -1
    }
    Text {
        id: percentageText
        text: battery.batteryPercentage
        color: colors.brightSnow
        anchors.left: root.left

        Behavior on anchors.leftMargin {
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
