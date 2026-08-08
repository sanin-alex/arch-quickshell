import QtQuick

import "../Types"

Rectangle {
    id: root
    Colors { id: colors }
    Wifi { id: wifi }
    Fonts { id: fonts }

    color: colors.onyx
    property var standardWidth: 24
    property var extendedWidth: 125
    implicitWidth: standardWidth 
    implicitHeight: 15
    clip: true

    property bool extended: false

    onExtendedChanged: {
        if(extended) {
            root.implicitWidth = extendedWidth
        } else {
            root.implicitWidth = standardWidth
        }
    }

    Behavior on implicitWidth {
        NumberAnimation {
            duration: 200
            easing.type: Easing.InOutQuad
        }
    }

    Text {
        id: signalStrenght
        text: wifi.signalStrengthSymbol 
        color: colors.brightSnow
        font { pixelSize: 15 }	
        anchors {
            right: root.right
            verticalCenter: root.verticalCenter
        }
    }
    Text {
        id: ssid
        text: wifi.currentNetwork
        color: colors.brightSnow
        font.family: fonts.name
        anchors.right: root.right
        anchors.rightMargin: 24
        anchors.verticalCenter: root.verticalCenter
    }
}
