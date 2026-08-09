import QtQuick

import "../Types"
import ".."

Rectangle {
    id: root
    Wifi { id: wifi }
    Fonts { id: fonts }
    Config { id: config }

    color: config.backgroundColor
    property var standardWidth: 24
    property var extendedWidth: 125
    readonly property int animationDuration: config.animationDuration
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
            duration: root.animationDuration 
            easing.type: Easing.InOutQuad
        }
    }

    Text {
        id: signalStrenght
        text: wifi.signalStrengthSymbol 
        color: config.surfaceColor
        font { pixelSize: 15 }	
        anchors {
            right: root.right
            verticalCenter: root.verticalCenter
        }
    }
    Text {
        id: ssid
        text: wifi.currentNetwork
        color: config.surfaceColor
        font.family: fonts.name
        anchors.right: root.right
        anchors.rightMargin: 24
        anchors.verticalCenter: root.verticalCenter
    }
}
