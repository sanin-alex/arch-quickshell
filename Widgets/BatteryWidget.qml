import QtQuick

import "../Types"

Rectangle {
    id: root
    Battery { id: battery }
    Colors { id: colors }
    Fonts { id: fonts }

    implicitWidth: standardWidth
    implicitHeight: 12
    color: colors.transparent
    clip: true

    property bool extended: false
    property int standardWidth: 24
    property int extendedWidth: 125

    Behavior on implicitWidth {
        NumberAnimation {
            duration: 200
            easing.type: Easing.InOutQuad
        }
    }

    onExtendedChanged: {
        if(extended) {
            root.implicitWidth = extendedWidth
        } else {
            root.implicitWidth = standardWidth
        }
    }
    Text {
        id: percentageText
        text: battery.batteryPercentage + "%"
        color: colors.brightSnow
        anchors.left: border.left
        anchors.leftMargin: 24
        anchors.verticalCenter: border.verticalCenter
        font.family: fonts.name
    }
    Rectangle {
        id: border
        implicitWidth: 18
        implicitHeight: 8
        radius: 15
        border.width: 1
        border.color: colors.brightSnow
        color: colors.onyx
        anchors.verticalCenter: root.verticalCenter 
        anchors.left: root.left
        anchors.leftMargin: 4

        Rectangle {
            id: batteryIndicator
            property var fullWidth: border.implicitWidth - 5
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
                left: border.right
                leftMargin: -1.5
                verticalCenter: border.verticalCenter
            }

            width: 2.5
            height: 4
            radius: 1
            color: colors.brightSnow
        }
    }
}
