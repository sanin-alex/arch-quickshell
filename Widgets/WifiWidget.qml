import QtQuick
import Quickshell

import "../Types"

Text {
    Colors { id: colors }
    Wifi { id: wifi }
	text: wifi.signalStrengthSymbol 
    color: colors.brightSnow
	font { pixelSize: 15 }	
}
